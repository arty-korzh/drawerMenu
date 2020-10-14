//
//  DrawerPresentationController.swift
//  Drawer Menu App
//
//  Created by Artem Korzh on 26.09.2020.
//

import UIKit

class DrawerPresentationController: UIPresentationController {

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 0.8, height: parentSize.height)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        guard let containerView = containerView else {
            return frame
        }
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
        return frame
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissPresentedController))
        view.addGestureRecognizer(tapRecognizer)

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(recognizer:)))
        view.addGestureRecognizer(panRecognizer)
        return view
    }()

    @objc private func dismissPresentedController() {
        presentedViewController.dismiss(animated: true)
    }

    @objc private func panGestureHandler(recognizer: UIPanGestureRecognizer) {

        guard let presentedView = presentedView else {
            return
        }

        switch recognizer.state {
        case .changed:
            let translation = recognizer.translation(in: dimmingView)
            guard translation.x < 0 else {
                return
            }
            presentedView.frame.origin = CGPoint(x: translation.x, y: 0)
        case .ended:
            if presentedView.frame.maxX < 100 {
                dismissPresentedController()
                return
            }
            let velocity = recognizer.velocity(in: dimmingView)
            if abs(velocity.x) > 1000 {
                dismissPresentedController()
            } else {
                UIView.animate(withDuration: 0.2) {
                    presentedView.frame.origin = .zero
                }
            }
        default:
            break
        }




    }

    override func presentationTransitionWillBegin() {
        guard  let containerView = containerView else {
            return
        }

        containerView.insertSubview(dimmingView, at: 0)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
            return
        }
        coordinator.animate { (_) in
            self.dimmingView.alpha = 1
        }
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0
            return
        }
        coordinator.animate { (_) in
            self.dimmingView.alpha = 0
        }
    }
}

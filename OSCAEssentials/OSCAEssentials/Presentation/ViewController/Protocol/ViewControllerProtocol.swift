//
//  OSCAViewController.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 11.08.22.
//

import UIKit

public protocol ViewControllerProtocol {
  var viewModel: ViewModelProtocol { get set }
  
  func viewDidLoad() -> Void
  func viewWillLayoutSubviews() -> Void
  func viewWillAppear() -> Void
  func viewDidAppear() -> Void
  func viewWillDisappear() -> Void
  func viewDidDisappear() -> Void
}// end public protocol ViewControllerProtocol

extension ViewControllerProtocol where Self: UIViewController {
  func viewDidLoad() -> Void {
    viewModel.viewDidLoad()
  }// end override func
  
  func viewWillLayoutSubviews() -> Void {
    viewModel.viewDidLoad()
  }// end override func
  
  func viewWillAppear(_ animated: Bool) -> Void {
    viewModel.viewWillAppear()
  }// end override func
  
  func viewDidAppear(_ animated: Bool) -> Void {
    viewModel.viewDidAppear()
  }// end override func
  
  func viewWillDisappear(_ animated: Bool) -> Void {
    viewModel.viewWillDisappear()
  }// end override func
  
  func viewDidDisappear(_ animated: Bool) -> Void {
    viewModel.viewDidDisappear()
  }// end override func
}// end extension ViewControllerProtocol 

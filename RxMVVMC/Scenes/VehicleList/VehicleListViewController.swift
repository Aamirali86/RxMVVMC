//
//  VehicleListViewController.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class VehicleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    var viewModel: VehicleListViewModelType
    
    // MARK:- Init
    init?(coder: NSCoder, viewModel: VehicleListViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        tableView.registerCell(VehicleCell.self)
    }
    
    private func bindViewModel() {
        viewModel
            .vehicles
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<VehicleTableViewSection> = {
        RxTableViewSectionedReloadDataSource<VehicleTableViewSection>(configureCell: {(dataSource, tableView, indexPath, rowData) -> UITableViewCell in
            switch rowData {
            case .vehicleTile(let vehicle):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: VehicleCell.cellIdentifier, for: indexPath) as? VehicleCell else {
                    return UITableViewCell()
                }
                let cellViewModel = VehicleCellViewModel(vehicle: vehicle)
                cell.populate(with: cellViewModel)
                return cell
            }
        })
    }()
}

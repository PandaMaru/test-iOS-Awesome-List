//
//  ListViewController.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import UIKit
import RxSwift
import IGListKit

class ListViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let disposeBag = DisposeBag()
    let viewModel = ListViewModel()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    var lists: [List] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.collectionView = listCollectionView
        adapter.dataSource = self
        
        viewModel.getList()
            .subscribeOnBackgroundAndObserveOnMain()
            .subscribe(onNext: {[weak self] lists in
                self?.lists = lists
                self?.adapter.reloadData(completion: nil)
            }, onError: {[weak self] error in
                print(error)
            }, onCompleted: {
                    
            }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return lists
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if let _ = object as? List {
            let customListSectionController = CustomListSectionController()
            customListSectionController.delegate = self
            
            return customListSectionController
        }
        
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension ListViewController: CustomListSectionDelegate {
    func updateSelfSizingCell(model: List) {
        print("update \(model.id)")
        adapter.reloadObjects([model])
    }
}

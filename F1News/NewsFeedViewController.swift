import UIKit
import SDWebImage

class NewsFeedViewController: UITableViewController {

    private let newsDataService = NewsDataWebService()
    private var newsDataItems: [NewsDataItem] = [NewsDataItem]()
    var cellPopulation: NewsCellPopulation?


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewViewCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")

        loadNewsData()
        cellPopulation = NewsCellPopulation()

        self.navigationItem.titleView = LogoImageView()
    }

    private func loadNewsData() {
        newsDataService.loadNewsData(completion: { [weak self] newsDataItems, error in
            guard let strongSelf = self else {
                return
            }

            if error != nil {
                print("There was an error while loading news data: \(String(describing: error))")
                return
            }

            strongSelf.newsDataItems = newsDataItems
            strongSelf.reloadData()
        })
    }

    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellPopulation?.populate(cell: cell, newDataItem: newsDataItems[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNewsViewVM = ArticleViewVM(newsDataItem: newsDataItems[indexPath.row])
 
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let selectedViewController = mainStoryBoard.instantiate(SelectedNewsViewController.self)
        selectedViewController.selectedNewsViewVM = selectedNewsViewVM
        
        self.navigationController?.pushViewController(selectedViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 332;
    }
}


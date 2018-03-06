import UIKit
import SDWebImage

class NewsFeedViewController: UITableViewController {

    private let newsDataService = NewsDataWebService()
    private var newsDataItems: [NewDataItem] = [NewDataItem]()
    var cellPopulation: NewsCellPopulation?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewViewCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")

        loadNewsData()
        cellPopulation = NewsCellPopulation()
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 332;
    }
}


import UIKit
import SDWebImage

class NewsFeedViewController: UITableViewController {

    private let newsDataService = NewsDataWebService()
    private var newsDataItems: [NewDataItem] = [NewDataItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewViewCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")

        loadNewsData()
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
        if let newCell = cell as? NewViewCell {
            
            let newDataItem: NewDataItem = newsDataItems[indexPath.row]
            newCell.titleLabel?.text = newDataItem.title
            newCell.descriptionLabel?.text = newsDataItems[indexPath.row].description
            newCell.publishedDateLabel?.text = newDataItem.publishedDate
            
            if let url = URL(string: newDataItem.imageURL) {
                
                newCell.imgView?.downloadAndSet(imageUrl: url)
            }
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 332;
    }
}


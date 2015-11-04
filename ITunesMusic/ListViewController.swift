//
//  ListViewController.swift
//
//1 private(アクセスコントロール)に関して
//　URL http://tea-leaves.jp/swift/content/%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%82%B3%E3%83%B3%E3%83%88%E3%83%AD%E3%83%BC%E3%83%AB
//　アクセスコントロールとは、プロパティやメソッドにアクセス制限を設ける事です。
//  この機能により、オブジェクト指向のカプセル化よりも細かい基準でコントロールする事ができます。
//  これらのアクセス制限はそれらが記述されているソースファイル基準で設定されます。
//  private 最も厳しいアクセス基準です。同じソースファイルからしかアクセスできません。
//  変数resultsのアクセスコントロールレベルをprivateにし、型をNSDictionaryに指定

//2 UISearchBarDelegateを用いて検索処理を実装する
//  URL http://secondflush2.blog.fc2.com/blog-entry-962.html
//  extension ListViewController: UISearchBarDelegateに関して
//  extension SwiftでObjective-Cの機能を扱うための拡張機能(構造体や列挙型にも扱える)
//  UISearchBarDelegateプロトコル UISearchBar(UIのパーツ,オブジェクト)のコントロール機能を実装するオプション機能を定義します。
//  UISearchBarオブジェクトは検索フィールドを持つバーのユーザーインターフェースを提供し、そのボタンがタップされた際のアクションの実行は
//  アプリケーションの責任となります。
//  つまり、delegateオプションを用いて実際のユーザからのアクションのコントロールを行います。

//3 ITunesAPIから情報を取得し、情報が存在する場合描画する。
//  (1)サーバとデータのやりとりを行うため、URLエンコードを行う必要があります
//  URL http://swift-salaryman.com/urlencode.php
//  なぜなら、文字化けが生じたりとデータに不備が生じてしまうからです。
//  方法 => stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())を使う
//  今回は、let text = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
//  text!の「!」は代入される値がnilである事を許可しないためのもの

//4
//  getメソッド(HTTP)でget以下のURLへ通信するタスクを生成
//  URL http://dev.classmethod.jp/smartphone/afsessionmanager/
//  AFHTTPSessionManager().GET("https://itunes.apple.com/search?term=\(text)&country=JP&lang=ja_jp&media=music", parameters: nil,)
//  itunes.apple.comからクエリパラメータで区切った値を取得している。
//  https => スキーム
//  itunes.apple.com => ホスト名
//  search => パス
//  ?term=... リクエストパラメータ <=> クエリパラメータと言う
//  クエリパラメータ Web APIに渡したい情報、各パラメータは「&」で区切る
//  ?term=\(text) 検索したい値
//  &country=JP どこに国のITunesStoreか => 日本で
//  &lang=ja_jp  結果は何語かを示す => 日本語
//  &media=music" 音楽を記録している媒体を取得する。

//5
// NSURLSessionDataTaskに関して
// まずはNSURLConnectionクラスの復習
// WebサーバやファイルサーバなどのデータソースからURLを指定してデータを非同期で取得することができるクラス
// このクラスを用いる事で、通信処理中にアプリ全体をブロックさせないように通信処理をかける。
// ただ、このクラスを使用する場合、「通信先のURL タイムアウト キャッシュ 認証方法」の設定を行う必要があり、
// データ取得ごとにこれらの設定を行わないといけません。
// この煩わしさを解消するのが「NSURLSession」です。
// あとは、NSDictionaryがたのresultに対して取得内容をTableViewに代入する
// NSURL型に関して => http://d.hatena.ne.jp/nakamura001/20110421/1303404341


//6
// ListCellにUIImageViewやUILabelのoutletを紐づける
// URL http://swift-ios.keicode.com/ios/outlet.php
// outletとは、ストーリーボード上のオブジェクトの参照を表す。

//7
// prepareForSegueに関して
// 指定遷移先の参照に対して情報(trackNameとPreviewUrl)を渡している。

//8
// outlet Storyboard上のオブジェクトを参照する値を定義する。変数searchbarはUISearchBarを参照できる。
// weakなので弱いつながりでしかない。

//9  return results?.count ?? 0 返り値が0かどうかを判定している。

//10　UITableViewControllerの詳細
// 「cellForRowAtIndexPath:」で指定したインデックスパスのセル（UITableViewCell）を作成し，
//　 そのインスタンスを返すように実装します．
dequeueReusableCellWithIdentifierに関して。
//    一度作成したセルを再利用することでパフォーマンスを向上させています．



import UIKit

class ListViewController: UITableViewController {
    //1
    private var results: [NSDictionary]?

    //8
    @IBOutlet weak var searchBar: UISearchBar!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //9
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results?.count ?? 0
    }


    //10
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListCell
        if let result = results?[indexPath.row] {
            if let artworkUrl = result["artworkUrl100"] as? String {
                cell.artworkImageView.setImageWithURL(NSURL(string: artworkUrl)!)
            } else {
                cell.artworkImageView.image = nil
            }
            cell.trackLabel.text = result["trackName"] as? String
            cell.artistLabel.text = result["artistName"] as? String
        }
        return cell
    }

    // MARK: - Navigation

//7
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow, result = results?[indexPath.row] {
                vc.trackName = result["trackName"] as! String
                vc.previewUrl = result["previewUrl"] as? String
            }
        }
    }


}

//2
extension ListViewController: UISearchBarDelegate {

    // searchBarのSearchボタンをタップしたときの処理
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // キーボードを閉じる
//3
        // url encode　例. スピッツ > %83X%83s%83b%83c
        let text = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
//4
        if let text = text {
            AFHTTPSessionManager().GET(
                "https://itunes.apple.com/search?term=\(text)&country=JP&lang=ja_jp&media=music",
                parameters: nil,
//5
                success: { (task: NSURLSessionDataTask!, response: AnyObject!) -> Void in
                    if let data = response as? NSDictionary, results = data["results"] as? [NSDictionary] {
                        self.results = results
                        self.tableView.reloadData() // 再描画
                    }
                },
                failure: nil)
        }
    }
}

//6
class ListCell: UITableViewCell {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
}

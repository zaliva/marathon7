import UIKit

class ViewController: UIViewController {
    
    var contentViewTopAnchor: NSLayoutConstraint!
    var headerViewHeightAnchor: NSLayoutConstraint!
    var defaultHeight: CGFloat = 270
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: defaultHeight - view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
    }
    
    func setupView(){
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalToConstant: scrollView.contentSize.width),
            contentView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height),
        ])
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0)
        contentViewTopAnchor.isActive = true
        
        
        contentView.addSubview(headerImageView)
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        headerViewHeightAnchor = headerImageView.heightAnchor.constraint(equalToConstant: defaultHeight)
        headerViewHeightAnchor.isActive = true
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "imageTop")
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetHeight = scrollView.contentOffset.y
        
        if contentOffsetHeight < 0 {
            contentViewTopAnchor.constant = contentOffsetHeight
            headerViewHeightAnchor.constant = defaultHeight - contentOffsetHeight
            
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: defaultHeight - view.safeAreaInsets.top - contentOffsetHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

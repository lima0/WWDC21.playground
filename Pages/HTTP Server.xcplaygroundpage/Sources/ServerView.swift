import Foundation
import UIKit

public class ServerView: UIViewController {
    
    public let response: ((Data) -> Void)? = nil

    let titleLabel = UILabel()
    let listenButton = UIButton()
    let goToServer = UIButton()

    var serverEnabled = false
    
    public override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 46/255, green: 52/255, blue: 64/255, alpha: 1)
    }
    
    public override func viewDidLoad() {
        setupView()
    }
    
    func setupView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "HTTP Server"
        titleLabel.textColor = UIColor(red: 216/255, green: 222/255, blue: 233/255, alpha: 1)
        titleLabel.font = titleLabel.font.withSize(30)
        view.addSubview(titleLabel)
        
        listenButton.translatesAutoresizingMaskIntoConstraints = false
        listenButton.setTitle("Listen on Port 80", for: .normal)
        listenButton.backgroundColor = UIColor(red: 129/255, green: 161/255, blue: 193/255, alpha: 1)
        listenButton.addTarget(self, action: #selector(listenHTTP), for: .touchUpInside)
        listenButton.titleLabel?.textColor = UIColor(red: 216/255, green: 222/255, blue: 233/255, alpha: 1)
        listenButton.layer.cornerRadius = 15
        listenButton.layer.shadowColor = UIColor.white.cgColor
        listenButton.layer.shadowOpacity = 1
        listenButton.layer.shadowOffset = .zero
        listenButton.layer.shadowRadius = 10
        listenButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        view.addSubview(listenButton)
        
        view.addSubview(goToServer)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            listenButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            listenButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            listenButton.bottomAnchor.constraint(equalTo: listenButton.topAnchor, constant: 50)
        ])
    }
    @objc func listenHTTP() {
        switch serverEnabled {
        case false:
            serverEnabled.toggle()
            Server.bindAndListen(port: 80)
            listenButton.setTitle("Stop listening on port 80", for: .normal)
            listenButton.layer.shadowColor = UIColor.green.cgColor
        case true:
            serverEnabled.toggle()
            Server.close()
            listenButton.setTitle("Listen on Port 80", for: .normal)
            listenButton.layer.shadowColor = UIColor.white.cgColor
        }
    }
}

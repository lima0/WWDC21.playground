import Foundation
import UIKit

public class SocketsViewController: UIViewController {
    
    public var clientPort = 3333
    public var serverPort = 3333
    
    let titleLabel = UILabel()
    let textField = UITextField()
    let serverOutPut = UILabel()
    let serverToggle = UISwitch()
    let clientActivate = UIButton()
    let serverStatus = UILabel()
    
    public override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 46/255, green: 52/255, blue: 64/255, alpha: 1)
    }
    
    public override func viewDidLoad() {
        setupView()
    }
    
    func setupView() {

        Server.dataReceived = { data, _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let date = formatter.string(from: Date())
            self.serverOutPut.text = "data received at \(date):\n" + (String(data: data, encoding: .utf8) ?? "EMPTY MESSAGE")
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Play around with network sockets"
        titleLabel.textColor = UIColor(red: 216/255, green: 222/255, blue: 233/255, alpha: 1)
        titleLabel.font = titleLabel.font.withSize(20)
        self.view.addSubview(titleLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 143/255, green: 188/255, blue: 187/255, alpha: 1)
        textField.placeholder = "Message to send"
        textField.delegate = self
        self.view.addSubview(textField)
        
        clientActivate.translatesAutoresizingMaskIntoConstraints = false
        clientActivate.setTitle("Connect and write message to port \(clientPort)", for: .normal)
        clientActivate.backgroundColor = UIColor(red: 129/255, green: 161/255, blue: 193/255, alpha: 1)
        clientActivate.addTarget(self, action: #selector(clientSendMessage), for: .touchUpInside)
        clientActivate.titleLabel?.textColor = UIColor(red: 216/255, green: 222/255, blue: 233/255, alpha: 1)
        clientActivate.layer.cornerRadius = 15
        clientActivate.contentEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        self.view.addSubview(clientActivate)
        
        serverOutPut.translatesAutoresizingMaskIntoConstraints = false
        serverOutPut.text = "server output will be visible here"
        serverOutPut.textColor = UIColor(red: 216/255, green: 222/255, blue: 233/255, alpha: 1)
        serverOutPut.lineBreakMode = .byWordWrapping
        serverOutPut.textAlignment = .center
        serverOutPut.numberOfLines = 0
        self.view.addSubview(serverOutPut)
        
        serverToggle.translatesAutoresizingMaskIntoConstraints = false
        serverToggle.addTarget(self, action: #selector(toggleServer), for: .valueChanged)
        view.addSubview(serverToggle)
        
        serverStatus.text = "<- Tap to listen on port \(serverPort)"
        serverStatus.textColor = UIColor(red: 216/255, green: 222/255, blue: 233/255, alpha: 1)
        serverStatus.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(serverStatus)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40),
            textField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40),
            textField.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: 50),

            clientActivate.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            clientActivate.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            clientActivate.bottomAnchor.constraint(equalTo: clientActivate.topAnchor, constant: 50),
            
            serverStatus.topAnchor.constraint(equalTo: clientActivate.bottomAnchor, constant: 10),
            serverStatus.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10),
            
            serverToggle.topAnchor.constraint(equalTo: serverStatus.topAnchor),
            serverToggle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
            
            serverOutPut.topAnchor.constraint(equalTo: serverStatus.bottomAnchor, constant: 20),
            serverOutPut.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            serverOutPut.bottomAnchor.constraint(equalTo: serverOutPut.topAnchor, constant: 80)
        ])
    }
    
    @objc func toggleServer(serverSwitch: UISwitch) {
        switch serverSwitch.isOn {
        case true:
            serverOutPut.text = " Server is listening on \(serverPort)"
            Server.bindAndListen(port: serverPort)
        case false:
            serverOutPut.text = " Toggle switch to listen on port \(serverPort)"
            Server.close()
        }
    }
    
    @objc func clientSendMessage(sender: UIButton!) {
        if !serverToggle.isOn {
            serverOutPut.text = " Server is offline, use toggle to activate!"
        }
        guard let message = textField.text else {
            return
        }
        Client.connect(port: clientPort)
        Client.write(data: Data(message.utf8)) { _ in
            Client.close()
        }
    }
}

extension SocketsViewController: UITextFieldDelegate {
    // limit textfield so it doesn't get out of the view
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text: NSString = textField.text as NSString? else {
            return false
        }
        let newText: NSString = text.replacingCharacters(in: range, with: string) as NSString
        return newText.length <= 40
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

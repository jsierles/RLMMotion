class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'RLMMotion'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    File.delete(RLMRealm.defaultRealmPath)

    realm = Realm.default
    realm.beginWriteTransaction
    p realm.createObject('Model', withObject: [2])
    realm.commitWriteTransaction

    p realm.allObjects('Model')

    true
  end
end

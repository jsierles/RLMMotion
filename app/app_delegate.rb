class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'RLMMotion'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    p Realm.defaultRealmPath
    File.delete(Realm.defaultRealmPath) if File.exist?(Realm.defaultRealmPath)

    realm = Realm.defaultRealm
    realm.beginWriteTransaction
    model = realm.createObject('Model', withObject: [2, nil])
    model.link = realm.createObject('Model', withObject: [10, model])
    realm.commitWriteTransaction

    puts realm.allObjects('Model').description

    true
  end
end

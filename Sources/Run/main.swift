import App

let main = try app(.detect())

try main.run()

//
//app.get("/") { request in
//	log.verbose("not so important")
//	log.debug("something to debug")
//	log.info("a nice information")
//	log.warning("oh no, that won’t be good")
//	log.error("ouch, an error did occur!")
//	return "welcome!"
//}
//
//app.run()


//// set-up SwiftyBeaver logging destinations (console, file, cloud, ...)
//let console = ConsoleDestination()  // log to Xcode Console in color
//let file = FileDestination()  // log to file
//file.logFileURL = URL(string: "file:///tmp/VaporLogs.log")! // set log file
//// add SwiftyBeaver destination instances to SwiftyBeaver Logging Provider
//let sbProvider = SwiftyBeaverProvider(destinations: [console, file])
//
//// create Droplet
//let app = Droplet(initializedProviders: [sbProvider])
//let log = app.log.self // to avoid writing app.log all the time
//app.get("/") { request in
//	log.verbose("not so important")
//	log.debug("something to debug")
//	log.info("a nice information")
//	log.warning("oh no, that won’t be good")
//	log.error("ouch, an error did occur!")
//	return "welcome!"
//}
//app.run()

class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/"(view:"/index")
        "/index"(view:"/index")
        "/about"(view:"/about")
        "/contact"(view:"/contact")
        "/access"(view:"/access")
        "/disclaim"(view:"/disclaim")
        "/resources"(controller: 'resource', action:'list')
        "500"(view:'/error')
	}
}

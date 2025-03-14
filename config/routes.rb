Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })

  # Authentication Routes
  get("/signup", { :controller => "users", :action => "new" })
  post("/users", { :controller => "users", :action => "create" })

  get("/login", { :controller => "sessions", :action => "new" })
  post("/sessions", { :controller => "sessions", :action => "create" })
  delete("/logout", { :controller => "sessions", :action => "destroy" })  

  # Resourceful Routes (CRUD)
  resources "entries"
  resources "places"
  resources "sessions", only: [:new, :create, :destroy]
  resources "users", only: [:new, :create]
end

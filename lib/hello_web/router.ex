defmodule HelloWeb.Router do
  #use HelloWeb, :router
  use HelloWeb, :router
  use Coherence.Router
  alias Hello.Accounts

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
    plug :attribute_checks
    plug :ensure_admin_access
  end

  pipeline :admin_access do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
    plug :attribute_checks
    plug :ensure_admin_access
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes
  end

  # Add this block
  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end
  scope "/", HelloWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    get "/hello", HelloController, :index
    resources "/countries", CountryController
    resources "/states", StateController
    resources "/companies", CompanyController
    resources "/roles", RoleController
    get "/listcountries", CountryController, :countrylist
    get "/liststates/:id", StateController, :statelist
    
  end
  scope "/", HelloWeb do
    pipe_through :protected # Use the default browser stack
    get "/", PageController, :index
    get "/hello", HelloController, :index
    resources "/countries", CountryController
    resources "/states", StateController
    resources "/companies", CompanyController 
    resources "/roles", RoleController
    get "/listcountries", CountryController, :countrylist
    get "/liststates/:id", StateController, :statelist  
  end
  # admin access scope
  scope "/", HelloWeb do
    pipe_through :admin_access
    resources "/users", UserController
  end

  def attribute_checks(conn, _) do
    u_id = Coherence.current_user(conn).id
    user_attributes = u_id
                        |> Accounts.get_user_attribute
    IO.inspect(user_attributes)
    conn = put_session(conn, :user_attributes, user_attributes)
  end

  def ensure_admin_access(conn, _) do
  #  admin_access=false
    [{a, b}] = get_session(conn, :user_attributes)
    if b==1 do
       conn
    else
      # todo raise appropriate error here
    end
  end
  
  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end

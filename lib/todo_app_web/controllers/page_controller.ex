defmodule TodoAppWeb.PageController do
  use TodoAppWeb, :controller
  
  alias TodoApp.Webapp
  alias TodoApp.Webapp.Task

  def index(conn, _params) do
    tasks = Webapp.list_tasks()
    changeset = Task.changeset(%Task{}, %{})
    render(conn, "index.html", tasks: tasks, changeset: changeset)
  end
end

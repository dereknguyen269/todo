defmodule TodoApp.WebappTest do
  use TodoApp.DataCase

  alias TodoApp.Webapp

  describe "tasks" do
    alias TodoApp.Webapp.Task

    @valid_attrs %{description: "some description", name: "some name", status: 42}
    @update_attrs %{description: "some updated description", name: "some updated name", status: 43}
    @invalid_attrs %{description: nil, name: nil, status: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Webapp.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Webapp.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Webapp.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Webapp.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.name == "some name"
      assert task.status == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Webapp.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Webapp.update_task(task, @update_attrs)
      assert task.description == "some updated description"
      assert task.name == "some updated name"
      assert task.status == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Webapp.update_task(task, @invalid_attrs)
      assert task == Webapp.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Webapp.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Webapp.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Webapp.change_task(task)
    end
  end
end

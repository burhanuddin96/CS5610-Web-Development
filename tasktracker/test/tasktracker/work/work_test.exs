defmodule Tasktracker.WorkTest do
  use Tasktracker.DataCase

  alias Tasktracker.Work

  describe "tasks" do
    alias Tasktracker.Work.Task

    @valid_attrs %{completed: true, desc: "some desc", name: "some name", timeHRS: 42, timeMIN: 42}
    @update_attrs %{completed: false, desc: "some updated desc", name: "some updated name", timeHRS: 43, timeMIN: 43}
    @invalid_attrs %{completed: nil, desc: nil, name: nil, timeHRS: nil, timeMIN: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Work.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Work.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Work.create_task(@valid_attrs)
      assert task.completed == true
      assert task.desc == "some desc"
      assert task.name == "some name"
      assert task.timeHRS == 42
      assert task.timeMIN == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Work.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.desc == "some updated desc"
      assert task.name == "some updated name"
      assert task.timeHRS == 43
      assert task.timeMIN == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_task(task, @invalid_attrs)
      assert task == Work.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Work.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Work.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Work.change_task(task)
    end
  end
end

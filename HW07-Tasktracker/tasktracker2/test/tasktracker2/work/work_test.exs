defmodule Tasktracker2.WorkTest do
  use Tasktracker2.DataCase

  alias Tasktracker2.Work

  describe "tasks" do
    alias Tasktracker2.Work.Task

    @valid_attrs %{completed: true, desc: "some desc", name: "some name"}
    @update_attrs %{completed: false, desc: "some updated desc", name: "some updated name"}
    @invalid_attrs %{completed: nil, desc: nil, name: nil}

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

  describe "timeblocks" do
    alias Tasktracker2.Work.TimeBlock

    @valid_attrs %{etime: "some etime", stime: "some stime"}
    @update_attrs %{etime: "some updated etime", stime: "some updated stime"}
    @invalid_attrs %{etime: nil, stime: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Work.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Work.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Work.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Work.create_time_block(@valid_attrs)
      assert time_block.etime == "some etime"
      assert time_block.stime == "some stime"
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Work.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.etime == "some updated etime"
      assert time_block.stime == "some updated stime"
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_time_block(time_block, @invalid_attrs)
      assert time_block == Work.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Work.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Work.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Work.change_time_block(time_block)
    end
  end
end

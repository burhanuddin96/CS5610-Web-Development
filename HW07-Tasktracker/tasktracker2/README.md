# Tasktracker2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).


Application Functionalities:
1. Some users are managers and some are employees.
2. Only managers can assign tasks to employees.
3. Managers can assign tasks to only the employees working under them.
4. Managers can view a report of all the tasks assigned to their underlings and whether or not the tasks are completed.
5. User can view tasks assigned to them from their hompage.
6. When a user clicks on "Show Task" button, he can view all details of the task including the timeblocks of the task.
7. The "Show Task" page also includes functionality to edit the timeblocks manually.
8. "Start Task" and "End Task" buttons are provided too.

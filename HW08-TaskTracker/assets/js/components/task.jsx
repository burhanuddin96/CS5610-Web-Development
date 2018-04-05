import React from 'react';
import { Card, CardBody } from 'reactstrap';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';

function Task(props) {
  let task = props.task;

  let status;

  if (task.completed) {
    status = "Task is completed.";
  } else {
    status = "Task is yet to be completed.";
  }

  function select(ev) {
    let data = {
      id: task.id,
      username: task.user.name,
      name: task.name,
      desc: task.desc,
      timeHRS: task.timeHRS,
      timeMIN: task.timeMIN,
      completed: task.completed,
    };

    props.dispatch({
      type: 'TASK_EDITION',
      data: data
    });
  }

    return <Card>
      <CardBody>
        <div>
           <p><b>{task.name}</b></p>
      		<p>Description: {task.desc}</p>
      		<p>Assigned to: <b>{task.user.name}</b></p>
      		<p>Time Spent: {task.timeHRS}&nbsp;hrs &nbsp;&nbsp; {task.timeMIN}&nbsp;min</p>
     		<p>{status}</p>
          <p>
            <Link to={"/tasks/" + props.task.id} onClick={select}>Edit Task</Link>
          </p>
        </div>
      </CardBody>
    </Card>;
  } 

function state2props(state) {
  return {};
}

export default connect(state2props)(Task);

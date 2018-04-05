import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';
import api from '../api';

// a form to edit a task
function EditTask(props) {


  function update(ev) {
   let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_ETASK_FORM',
      data: data
    };
    console.log(action);
    props.dispatch(action);
  }
  

  function submit(ev) {
  console.log("Edit Task Submit")
    let data = {
      task_id: props.eform.id,
      task: {
      	id: props.eform.id,
        name: props.eform.name,
      	desc: props.eform.desc,
      	timeHRS: props.eform.timeHRS,
      	timeMIN: props.eform.timeMIN,
      	completed: props.eform.completed,
      }
    };

    api.update_task(props.eform);
    props.dispatch({
      type: 'CLEAR_ETASK_FORM'
    });
    console.log(props.eform);
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_ETASK_FORM'
    });
  }

  let increments = _.range(0, 10080, 15);
  let options = _.map(increments, (ii) => <option key={ii}>{ii}</option>);
  let path = "/users/" + props.token.user_id;
  let complete;
  let incomplete;

  return <div>
    <h2>Edit Task</h2>
    	<strong>Assigned To:</strong> {props.eform.username}
        <FormGroup>
          <Label for="name">Task Name:</Label>
          <Input name="name" value={props.eform.name}
            onChange={update} />
        </FormGroup>
        <FormGroup>
          <Label for="desc">Task Description:</Label>
          <Input type="textarea" name="desc"
            value={props.eform.desc} onChange={update} />
        </FormGroup>
        <FormGroup>
          <Label for="timeHRS">Time Spent:</Label>
          <Input type="number" name="timeHRS" min="0"
            value={props.eform.timeHRS} onChange={update} /> hrs
          <Input type="number" name="timeMIN" min="0" max="45" step="15"
            value={props.eform.timeMIN} onChange={update} /> min
        </FormGroup>
        <FormGroup>
          <Label for="completed">Task Completed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</Label>
          <Input type="checkbox" name="completed"
            value={props.eform.completed} onChange={update} />
        </FormGroup>
        <Button onClick={submit} className="btn btn-primary">Update Task</Button>
        <Button onClick={clear} className="btn btn-secondary">Cancel</Button>
  </div>;
}

function state2props(state) {
  console.log("Edit Task", state);
  return {
    eform: state.eform,
    token: state.token
  };
}

export default connect(state2props)(EditTask);

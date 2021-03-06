import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';


function NewTask(props) {
  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_NTASK_FORM',
      data: data
    };
    console.log(action);
    props.dispatch(action);
  }

  function submit(ev) {
    api.submit_task(props.nform);
    props.dispatch({
      type: 'CLEAR_NTASK_FORM'
    });
    console.log(props.nform);
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_NTASK_FORM'
    });
  }

  let users = _.map(props.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);

  return <div>
    <h2>New Task</h2>
    <div className="card">
      <div className="card-body">
        <FormGroup>
          <Label for="user_id">Assign To:</Label>
          <Input type="select" name="user_id"
            value={props.nform.user_id} onChange={update}>
            <option></option>
            {users}
          </Input>
        </FormGroup>
        <FormGroup>
          <Label for="name">Task Name:</Label>
          <Input name="name" value={props.nform.name}
            onChange={update} />
        </FormGroup>
        <FormGroup>
          <Label for="desc">Task Description:</Label>
          <Input type="textarea" name="desc"
            value={props.nform.desc} onChange={update} />
        </FormGroup>
        <FormGroup>
          <Label for="timeHRS">Time Spent:</Label>
          <Input type="number" name="timeHRS"
            value={props.nform.timeHRS} onChange={update} /> hrs
          <Input type="number" name="timeMIN"
            value={props.nform.timeMIN} onChange={update} /> min
        </FormGroup>
        <FormGroup>
          <Label for="completed">Task Completed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</Label>
          <Input type="checkbox" name="completed"
            value={props.nform.completed} onChange={update} />
        </FormGroup>
        <Button onClick={submit} color="primary">create task</Button>
        <Button onClick={clear} color="secondary">clear form</Button>
      </div>
    </div>
  </div>;
}

function state2props(state) {
  console.log("New Task", state);
  return {
    nform: state.nform,
    users: state.users,
    token: state.token
  };
}

export default connect(state2props)(NewTask);

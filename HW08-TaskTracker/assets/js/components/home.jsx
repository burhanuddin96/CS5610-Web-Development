import React from 'react';
import { Form, FormGroup, Label, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';

import Feed from './feed';

function Home(props) {
  if (props.token == null) {
  	

  	function submit(ev) {
		ev.preventDefault();  	
	  	
	  	var $inputs = $('#register :input');
    	var data = {};
    	$inputs.each(function() {
        	data[this.name] = $(this).val();
    	});
		delete data[""];
  		console.log(data);
  		api.new_user(data);
  		
  		
  		document.getElementById("register").reset();
  	}
  
    return <div style={{padding: "4ex"}}>
    	<h2> Sign Up!! </h2>
    	<form id="register">
    	<FormGroup>
    		<Label for="name">Name</Label>
    		<Input type="text" name="name"/>
    	</FormGroup>
    	<FormGroup>
    		<Label for="email">Email</Label>
    		<Input type="text" name="email"/>
    	</FormGroup>
    	<FormGroup>
    		<Label for="password">Password</Label>
    		<Input type="password" name="password"/>
    	</FormGroup>
    	<Button onClick={submit} color="primary">Register</Button>
    	</form>
    </div>;
  }
  else{
  	return <div>
  			<h2> My Tasks: </h2>
  			<Feed tasks={props.tasks} user_id={props.token.user_id} />
  		</div>;
  }	
}

function state2props(state) {
  return {
    tasks: state.tasks,
    token: state.token
  };
}

export default connect(state2props)(Home);

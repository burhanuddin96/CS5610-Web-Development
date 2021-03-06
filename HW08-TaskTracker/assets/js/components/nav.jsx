import React from 'react';
import { NavLink, Link } from 'react-router-dom';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';


let LoginForm = connect(({login}) => {return {login};})((props) => {
	function update(ev) {
		let tgt = $(ev.target);
		let data = {};
		data[tgt.attr('name')]=tgt.val();
		props.dispatch({
			type: 'UPDATE_LOGIN_FORM',
			data: data,
		});
	}
	
	function create_token(ev) {
		let data = {email: props.login.email,
					password: props.login.password};
		api.submit_login(data);
		console.log("Login", data);
	}

	return (<div>
		<Form className="form-inline my-2 my-lg-0">
				<FormGroup>
				<Input className="mr-sm-2" type="text" name="email" placeholder="email"
						value={props.login.email} onChange={update} />
				<Input className="mr-sm-2" type="password" name="password" placeholder="password"
						value={props.login.password} onChange={update} />
				</FormGroup>
			<Button className="btn my-2 my-sm-0" color="primary" onClick={create_token}>Login</Button>
		</Form>
		<p className="blockquote-footer text-right">{props.login.msg}</p>
		</div>);
});

let Session = connect(({token}) => {return {token};})((props) => {
	function logout(ev) {
		props.dispatch({
			type: 'LOG_OUT',
			msg: "Logged out successfully",
		});
	}
	
	return <div className="navbar-text text-right">
		Logged in as: {props.token.username}&nbsp;&nbsp;
		<Link to="/" onClick={logout} className="primary">Logout</Link>	
	</div>;
});



function Nav(props) {
  let to_my_tasks;
  let nav_links;
  let login_status;

  if (props.token) {
    nav_links =
      <ul className="navbar-nav mr-auto">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link">My Tasks</NavLink>
        </NavItem>
        <NavItem>
          <NavLink to="/tasks/new" href="#" activeClassName="active" className="nav-link">New Task</NavLink>
        </NavItem>
      </ul>;
    login_status = <Session token={props.token} />;
  }
  else {
    nav_links = <div></div>
    login_status = <LoginForm />;
  }

  return (
    <nav className="navbar navbar-dark bg-dark navbar-expand justify-content-between">
    	<span className="navbar-brand">Task Tracker</span>
        {nav_links}
      	{login_status}
    </nav>
  );
}

function state2props(state) {
  return {
    token: state.token
  };
}

export default connect(state2props)(Nav);


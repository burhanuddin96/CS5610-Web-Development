import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider, connect } from 'react-redux';

import Nav from './nav';
import Home from './home';
import NewTask from './newtask';
//import Users from './users';
import EditTask from './edittask';


export default function tasktracker_init(store) {
	let root = document.getElementById('root');
	ReactDOM.render(<Provider store={store}><TaskTracker state={store.getState()} /></Provider>, root);
}

let TaskTracker = connect((state) => state)((props) => {
	
	return (
		<Router>
			<div>
				<Nav />
				<Route path="/" exact={true} render={() =>
						<Home />					
				}/>
				<Route path="/tasks/new" exact={true} render={() =>
						<NewTask />					
				}/>
				<Route path="/tasks/:task_id" exact={true} render={() =>
						<EditTask />					
				}/>
			</div>
		</Router>
	);	
});

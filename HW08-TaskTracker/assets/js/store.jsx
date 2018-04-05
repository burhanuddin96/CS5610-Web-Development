import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

/*
 *  state layout:
 *  {
 *   tasks: [... Tasks assined to current user ...],
 *   users: [... List of users ...],
 *   nform: {
 *     user_id: null,
 *     body: "",
 *   }
 	eform
 	 login: {
 	 	email: null,
 	 	password: "",
 	 }
 	 token: {
 	 	user_id: "",
 	 	username: "",
 	 	token: "",
 	 }
 * }
 */

function tasks(state = [], action) {
  switch (action.type) {
    case 'TASKS_LIST':
      return [...action.tasks];
    case 'ADD_TASK':
      return [action.task, ...state];
    case 'LOG_OUT':
      return [];
    default:
      return state;
  }
}


function users(state = [], action) {
  switch (action.type) {
    case 'USERS_LIST':
      return [...action.users];
    case 'ADD_USER':
      return [action.user, ...state];
    case 'LOG_OUT':
      return [];
    default:
      return state;
  }
}

let empty_ntform = {
  user_id: "",
  name: "",
  desc: "",
  timeHRS: 0,
  timeMIN: 0,
  completed: false,
};

function nform(state = empty_ntform, action) {
  switch (action.type) {
    case 'UPDATE_NTASK_FORM':
      return Object.assign({}, state, action.data);
    case 'CLEAR_NTASK_FORM':
      return Object.assign({}, state, empty_ntform);
    case 'LOG_OUT':
      return empty_ntform;
    default:
      return state;
  }
}

let empty_etform = {
  task_id: "",
  username: "",
  name: "",
  desc: "",
  timeHRS: 0,
  timeMIN: 0,
  completed: false,
};

function eform(state = empty_ntform, action) {
  switch (action.type) {
  	case 'TASK_EDITION':
  	  return Object.assign({}, state, action.data);
    case 'UPDATE_ETASK_FORM':
      return Object.assign({}, state, action.data);
    case 'CLEAR_ETASK_FORM':
      return Object.assign({}, state, empty_etform);
    case 'SET_TOKEN':
      return Object.assign({}, state, {token: action.token.token });
    case 'LOG_OUT':
      return empty_etform;
    default:
      return state;
  }
}


let empty_login = {
	email: "",
	password: "",
	msg: " ",
};


function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    case 'LOG_OUT':
      return Object.assign({}, empty_login, {msg: action.msg});
    default:
      return state;
  }
}


function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    case 'LOG_OUT':
      return null;
    default:
      return state;
  }
}
	

function root_reducer(old_state, action) {
  console.log("old state:", old_state)
  console.log("reducer", action);
  let reducer = combineReducers({tasks, users, nform, eform, login, token});
  let new_state = reducer(old_state, action);
  console.log("new state:", new_state);
  return deepFreeze(new_state);
};

let store = createStore(root_reducer);
export default store;

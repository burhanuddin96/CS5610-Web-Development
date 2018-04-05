import React from 'react';
import Task from './task';

export default function Feed(params) {

  let tasks = _.filter(params.tasks, (tt) => tt.user.id == params.user_id)
  
  let task_cards = _.map(tasks, (pp) => <Task key={pp.id} task={pp} />);
  return <div>
    { task_cards }
  </div>;
}

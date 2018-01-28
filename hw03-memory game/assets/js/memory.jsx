import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function game_init(root) {
  ReactDOM.render(<MemoryGame />, root);
}


class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      letter_array: ['B', 'C', 'H', 'F', 'A', 'C', 'E', 'D', 'B', 'E', 'D', 'F', 'G', 'H', 'A', 'G',],
      mem_values: [],
      tile_ids: [],
      tileFlips: 0,
      moves: 0,
    };
  }
  
//Returns the number of moves made.
  moves(){
  	return this.state.moves;
  }
  
  
//Returns a list of ids of the tiles matched
  tile_ids(){
  	return this.state.tile_ids;
  }

//Returns a list of letters
  letters() {
    return this.state.letter_array;
  }

//Returns number of cards successfully flipped.
  tileFlips() {
    return this.state.tileFlips;
  }
  
//Returns value of flipped cards during a guess cycle.
  mem_val(){
  	return this.state.mem_values;
  }

//Resets the state of game when user selects NEW GAME.
//Shuffles the tiles for every new game.
  resetGame(ev) {
  	let newLarray = tile_shuffle(this.letters());
  	let newState = _.extend(this.state, {
  		letter_array: newLarray,
  		mem_values: [],
  		tile_ids: [],
  		tileFlips: 0,
  		moves: 0,
  		});
  	this.setState(newState);
  }
  
//Resets the state of game when a particular tile is clicked.
  tile_clicked(nmem_values, ntile_ids, flips, nmoves){
  let newState = _.extend(this.state, {
  		mem_values: nmem_values,
  		tile_ids: ntile_ids,
  		tileFlips: flips,
  		moves: nmoves,
  		});
  	this.setState(newState);
  }
  
  render() {
    return (
    	
    	<div className="row justify-content-md-center">
    	<div className="col col-lg-2">											
    		<Newgame game={this.resetGame.bind(this)}/><br/>
    		<Flips root={this}/>
    		<Moves root={this}/>
    	</div>
    	<div className="col-md-auto">
    		<BoardDes root={this}/>
    	</div>
    	</div>
    );
  }
}


//Function renders the board after each user interaction.
function BoardDes(params)
{
	let root=params.root;
	let letter_array = root.letters();
	let matched = root.tile_ids();
	let tiles = [];
	
	for(let i=0; i<letter_array.length; i++)
	{
		let tileID = "tile_" + i;
		if(matched.includes(tileID))
			tiles.push(<div className="ftile" id={tileID} onClick={flipTile.bind(this, tileID, letter_array[i], params)}>{letter_array[i]}</div>);
		else
			tiles.push(<div className="uftile" id={tileID} onClick={flipTile.bind(this, tileID, letter_array[i], params)}></div>);
	}
	return <div id="board">{tiles} </div>;
}


//Function handles the NEW_GAME button. 
function Newgame(params)
{
	return (<div>
    <p><button type="button" className="button" onClick={params.game}>New Game</button></p>
  	</div>);
}

//Function to display the number of successfully flipped tiles.
function Flips(params)
{
	return (<div>
    <p><h5>Tiles Flipped: {params.root.tileFlips()}</h5></p>
  	</div>);
}

//Function to display the number of moves made.
function Moves(params)
{
	return (<div>
    <p><h5>Moves: {params.root.moves()}</h5></p>
  	</div>);
}

//Function to shuffle the tiles.
function tile_shuffle(lArray) {
	let letter_array = lArray;
	let i = letter_array.length;
	while(--i > 0){
		let j = Math.floor(Math.random() * (i+1));
		let temp = letter_array[j];
		letter_array[j] = letter_array[i];
		letter_array[i] = temp;
	}
	return letter_array;
}

//Function to handle all clicks made on tiles.
function flipTile(tileID, value, params)
  {
  	let root = params.root;
  	let mem_values = root.mem_val();
  	let tile_ids = root.tile_ids();
  	let flips = root.tileFlips();
  	let moves = root.moves();
  
	let tile = document.getElementById(tileID);
	if(tile.innerHTML == "" && mem_values.length < 2)
	{
		moves += 1;
		//First click in the guess cycle.		
		if(mem_values.length == 0)
		{
			mem_values.push(value);
			tile_ids.push(tileID);
			root.tile_clicked(mem_values, tile_ids, flips, moves);
		}
		//Second click in the guess cycle.
		else if(mem_values.length==1)
		{
			tile_ids.push(tileID);
			root.tile_clicked(mem_values, tile_ids, flips, moves);
			
			mem_values.push(value);

			//If the guess is successful...	
			if(mem_values[0] === mem_values[1])
			{
				flips += 2;
				mem_values = [];
				root.tile_clicked(mem_values, tile_ids, flips, moves);
			}
			else
			{
				//Timesout for one second when guesses are unsuccesssful.
				setTimeout(function(){ 
        				tile_ids.pop();
					tile_ids.pop();
					mem_values = [];
					root.tile_clicked(mem_values, tile_ids, flips, moves);
    				}, 1000);
			}
		}
	}
  }

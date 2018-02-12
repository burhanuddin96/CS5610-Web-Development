import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function game_init(root, channel) {
  ReactDOM.render(<MemoryGame channel={channel} />, root);
}


class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = {
      letter_array: [],
      mem_values: [],
      tile_ids: [],
      tileFlips: 0,
      moves: 0,
    };
    this.firstLetter = [];
    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join game.", resp) })
  }

//Sets new state after each user interaction.
  gotView(view) {
	console.log("New view", view);
    this.setState(view.game);
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
  	this.firstLetter = [];
  	this.channel.push("newGame",{},)
  		.receive("ok", this.gotView.bind(this));
  }
  
//Resets the state of game when a particular tile is clicked.
  tile_clicked(tileID, letter){
 	this.channel.push("tileClick",{tileID: tileID, letter: letter},)
  		.receive("ok", this.gotView.bind(this));
  }

//Changes state after the one second timeout after second letter is guessed incorrectly. 
  timeout() {
  	this.channel.push("timeout",{},)
  		.receive("ok", this.gotView.bind(this));
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
			tiles.push(<div className="ftile" key={tileID} id={tileID} onClick={flipTile.bind(this, tileID, letter_array[i], params)}>{letter_array[i]}</div>);
		else
			tiles.push(<div className="uftile" key={tileID} id={tileID} onClick={flipTile.bind(this, tileID, letter_array[i], params)}></div>);
	}
	return <div key= "board" id="board">{tiles} </div>;
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
    <h5>Tiles Flipped: {params.root.tileFlips()}</h5>
  	</div>);
}

//Function to display the number of moves made.
function Moves(params)
{
	return (<div>
    <h5>Moves: {params.root.moves()}</h5>
  	</div>);
}

//Function to handle all clicks made on tiles.
function flipTile(tileID, letter, params)
{
  	let root = params.root;
	let tile = document.getElementById(tileID);
	//Sync firstLetter array after window refresh or relogin.
	if(root.mem_val().length == 1 && root.firstLetter.length == 0)
		root.firstLetter.push(root.mem_val()[0]);
	
	if(tile.innerHTML == "" && root.firstLetter.length < 2)
	{
		//Update state after tile clicked.
		root.tile_clicked(tileID, letter);
		root.firstLetter.push(letter)
		//After second click in guess cycle.
		if(root.firstLetter.length == 2)
		{
			if(root.firstLetter[0] != root.firstLetter[1])
			{
				console.log("Wrong Guess.")
				//Timeout for one second and change state.
				setTimeout(function() {
					root.firstLetter.pop();
					root.firstLetter.pop();
					root.timeout()
				}, 1000);
			}
			else
			{
				root.firstLetter.pop();
				root.firstLetter.pop();
				console.log("Tile Matched.")
			}
		}
	}
}		



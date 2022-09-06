import React from 'react';
 

const Gadgets = (props) => {

   
    return (
      <div className='conatainer'> 
      <div className='cards'> 
      <div className='row'> 
      {props.gadget.map((gadd) => (
      <div className='col-md-4' key={gadd.index}> 
      <div className='card text-center'>

        <div class="card-img">
          <img src={gadd.image} alt='img'/>
          </div>
        
        <div className='card-body text-dark'>
          <h4 className='card-name'>Card Name {gadd.name}</h4>
          <p className='card-text text-seconadry'>Description {gadd.description}</p>
          <h4 className='price'>price {gadd.price / 1000000000000000000}cUSD</h4>
          <div>
          {props.onlyOwner !== gadd.owner && (
          <a href='/#' className='btn btn-outline-success btw' onClick={() => props.buyGadget(gadd.index)}>Buy Gadget</a>
          )}
          
          {props.onlyOwner === gadd.owner && (
            <div>
          
            <button type='button' class="btn btn-outline-dark btw" onClick={ ()=> props.RemoveGadget(gadd.index)}>unpublish Magazine</button>
                 </div>
          )}
          </div>
          
        </div>
      </div>
      </div>
      ))}
      </div>
      </div>
      </div>
    )
  
    }
  
  
  
  
  
  export default Gadgets;
import React from 'react'

import { useState } from "react";

const CreateGadget = (props) => {
const [image, setImage] = useState('');
 const [name, setName] = useState('');
 const [description, setDescription] = useState('');
 const [price, setPrice] = useState();

 const submitHandler = (e) => {
    e.preventDefault();

    if(!image || !name || !description|| !price) {
        alert('Please fill up the form')
        return

    }
    props.AddGadget(image, name, description, price);
    
    setImage('')
    setName('')
    setDescription('')
    setPrice('')
};

return(
    <body>

    <div class="input">

        <h1 class="text-center">input your Gadget details</h1>
        
        <form class="needs-validation">
            <div class="form-group was-validated">
                <label class="form-label" for="email">Enter Image</label>
                <input class="form-control" type="text" id="email" value={image} required 
                    onChange={(e) => setImage(e.target.value)}
                />
                
                    Please enter your image 
                 
            </div>
            <div class="form-group was-validated">
                <label class="form-label" for="email">Enter name</label>
                <input class="form-control" type="text" id="email" value={name} required 
                    onChange={(e) => setName(e.target.value)}
                />
                
                    Please enter the name of gadget
                 
            </div>
            <div class="form-group was-validated">
                <label class="form-label" for="email">Enter description</label>
                <input class="form-control" type="text" id="email" value={description} required 
                    onChange={(e) => setDescription(e.target.value)}
                />
                
                    Please enter description of gadget 
                 
            </div>
            <div class="form-group was-validated">
                <label class="form-label" for="text">Enter price</label>
                <input class="form-control" type="text" id="email" value={price} required 
                    onChange={(e) => setPrice(e.target.value)}
                />
                
                    Please enter price of gadget
                 
            </div>
            <input class="btn btn-success w-100" type="submit" >Add Gadget</input>
            
            
        </form>

    </div>

</body>
  
)
}
export default  CreateGadget;
   
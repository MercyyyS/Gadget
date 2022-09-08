import React from "react";

import { useState } from "react";

const CreateGadget = (props) => {
	const [image, setImage] = useState("");
	const [name, setName] = useState("");
	const [description, setDescription] = useState("");
	const [price, setPrice] = useState("");

	const submitHandler = (e) => {
		e.preventDefault();

		if (!image || !name || !description || !price) {
			alert("Please fill up the form");
			return;
		}
		props.AddGadget(image, name, description, price);

		setImage("");
		setName("");
		setDescription("");
		setPrice("");
	};

	return (
		<>
			<div className="input">
				<h1 className="text-center">input your Gadget details</h1>

				<form className="needs-validation">
					<div className="form-group was-validated">
						<label className="form-label" htmlFor="image">
							Enter Image
						</label>
						<input
							className="form-control"
							type="text"
							id="image"
							value={image}
							required
							onChange={(e) => setImage(e.target.value)}
						/>
						Please enter your image
					</div>
					<div className="form-group was-validated">
						<label className="form-label" htmlFor="name">
							Enter name
						</label>
						<input
							className="form-control"
							type="text"
							id="name"
							value={name}
							required
							onChange={(e) => setName(e.target.value)}
						/>
						Please enter the name of gadget
					</div>
					<div className="form-group was-validated">
						<label className="form-label" htmlFor="description">
							Enter description
						</label>
						<input
							className="form-control"
							type="text"
							id="description"
							value={description}
							required
							onChange={(e) => setDescription(e.target.value)}
						/>
						Please enter description of gadget
					</div>
					<div className="form-group was-validated">
						<label className="form-label" htmlFor="price">
							Enter price
						</label>
						<input
							className="form-control"
							type="text"
							id="price"
							value={price}
							required
							onChange={(e) => setPrice(e.target.value)}
						/>
						Please enter price of gadget
					</div>
					<a className="btn btn-success w-100" type="submit" href="/#" onClick={e => submitHandler(e)}>
						Add Gadget
					</a>
				</form>
			</div>
		</>
	);
};
export default CreateGadget;
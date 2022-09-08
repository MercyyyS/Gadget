import React from "react";

const Gadgets = (props) => {
	return (
		<div className="container">
			<div className="cards">
				<div className="row mt-5">
					{props.gadgets.map((gadd) => (
						<div className="col-md-4" key={gadd.index}>
							<div className="card text-center mt-5">
								<img
									src={gadd.image}
									alt="img"
									className="card-img-top"
								/>

								<div className="card-body text-dark">
									<h4 className="card-name">
										Gadget Name: {gadd.name}
									</h4>
									<p className="card-text text-seconadry">
										Description:{gadd.description}
									</p>
									<h4 className="price">
										price {gadd.price /  1000000000000000000}
										cUSD
									</h4>
									<div>
										{gadd.owner !== props.address && (
											<a
												href="/#"
												className="btn btn-outline-success btw"
												onClick={() =>
													props.buyGadget(gadd.index)
												}
											>
												Buy glass
											</a>
										)}

										{gadd.owner === props.address && (
											<div>
												<button
													type="button"
													className="btn btn-outline-dark btw"
													onClick={() =>
														props.RemoveGadget(
															gadd.index
														)
													}
												>
													remove gadget
												</button>
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
	);
};

export default Gadgets;
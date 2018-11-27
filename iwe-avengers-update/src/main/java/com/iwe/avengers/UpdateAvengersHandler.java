package com.iwe.avengers;

import java.util.Optional;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dao.AvengerDAO;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.exception.AvengerNotFoundException;

public class UpdateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {
	private AvengerDAO dao = new AvengerDAO();
	
	
	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		final String id = avenger.getId();
		
		context.getLogger().log( "[#] - Searching Avenger by id: " + id);
		
		final Optional<Avenger> avengerRetieved = dao.search( id );
		
		if( avengerRetieved.isPresent() ){
			context.getLogger().log( "[#] - Update Avenger " + avengerRetieved.get().getName() );
			
			final Avenger avengerUpdate = dao.update( avenger );
			
			return HandlerResponse.builder().setObjectBody( avengerUpdate ).build();
		}
		
		throw new AvengerNotFoundException( "[NotFound] - Avenger id: " + id );
	}
}

package com.iwe.avengers;

import java.util.Optional;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dao.AvengerDAO;
import com.iwe.avengers.exception.AvengerNotFoundException;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.response.HandlerResponse;

public class SearchAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDAO dao = new AvengerDAO();

	@Override
	public HandlerResponse handleRequest( final Avenger avenger, final Context context ){

		final String id = avenger.getId();
		
		context.getLogger().log( "[#] - Searching Avenger by id: " + id);
		
		final Optional<Avenger> avengerRetieved = dao.search( id );
		
		if( avengerRetieved.isPresent() ){
			context.getLogger().log( "[#] - Avenger found " + avengerRetieved.get().getName() );
			
			
			return HandlerResponse.builder().setObjectBody( avengerRetieved.get() ).build();
		}

		return null;
		//throw new AvengerNotFoundException( "[NotFound] - Avenger id: " );

	}
}

package com.airline.booking.handlers;

import org.springframework.stereotype.Component;

import com.sap.cds.Result; 
import com.sap.cds.ql.Select; 
import com.sap.cds.services.cds.CdsCreateEventContext; 
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import cds.gen.catalogservice.Flights;
import cds.gen.catalogservice.Flights_;
import cds.gen.catalogservice.Bookings_;
import cds.gen.catalogservice.Bookings;

@Component
@ServiceName("CatalogService")
public class BookingServiceHandler implements EventHandler {

    private final PersistenceService db;
    public BookingServiceHandler(PersistenceService db) {
        this.db = db;
    }
    @Before(event = "CREATE", entity = Bookings_.CDS_NAME)
    public void beforeCreateBooking(CdsCreateEventContext context, Bookings booking) {
        String flightId = booking.getFlightId();
        Result result = db.run(Select.from(Flights_.CDS_NAME).where(f -> f.get("ID").eq(flightId)));
        Flights flight = result.single(Flights.class);
        if (flight.getAvailableSeats() <= 0) {
            throw new RuntimeException("No seats available for this flight");
        }
        System.out.println("Seat validation successful");
    }
}
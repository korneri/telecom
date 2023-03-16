package f2821907;

import java.sql.*;  
import java.util.ArrayList;

class telecom{  
	public static void main(String args[]){  
		try{  
			// This will load the MySQL driver
			Class.forName("com.mysql.jdbc.Driver");
			//connecting to database using username and password of database
			Connection con=DriverManager.getConnection(  
					"jdbc:mysql://localhost:3306/telecom","root","YourSqlCode");  
			// Statements allow to issue SQL queries to the database
			Statement stmt=con.createStatement(); 
			Statement stmt2=con.createStatement();
			// Result set get the result of the SQL query
			ResultSet rs=stmt.executeQuery("select city_id,duration from customer,callT,contract "
					+ "  where customer.id = contract.customer_id AND contract.id = callT.contract_id AND YEAR(date_call) = '2018' ");
			ResultSet rs2 =stmt2.executeQuery("select id,population from city");
			
			//ArrayList that  will contain the city per duration
			ArrayList<String> cityDurList = new ArrayList<String>();
			//ArrayList for duration
			ArrayList<Double> durationList = new ArrayList<Double>();
			while(rs.next()){ 
				cityDurList.add(rs.getString(1));
				durationList.add(rs.getDouble(2));
			}
		    
		    
		  //ArrayList that  will contain the city per population
			ArrayList<String> cityPopList = new ArrayList<String>();
			//ArrayList for duration
			ArrayList<Double> populationList = new ArrayList<Double>();
			while(rs2.next()){
				cityPopList.add(rs2.getString(1));
				populationList.add(rs2.getDouble(2));
			}
			con.close(); 
			
			//total duration of calls of all cities
			double total_duration = 0;
			for(Double temp:durationList){
				total_duration += temp;
			}
			//total population of all cities
			double total_population = 0;
			for(Double temp:populationList){
				total_population += temp;
			}
			
			//titles of columns
			System.out.println("CityId  DurationRatio       PopulationRatio  ");
			
			for(int j=0; j < cityPopList.size(); j++ ){
				double ratio_duration = 0;
				//if there are calls made from this city
				if(cityDurList.contains(cityPopList.get(j))){
					double sum = 0;
					for(int i=0; i < durationList.size(); i++){
						
						if(cityDurList.get(i).equals(cityPopList.get(j))){
							sum += durationList.get(i);
						}
					}
					ratio_duration = sum / total_duration;
				}
				double ratio_population = populationList.get(j) / total_population;
				
				//printing the results
				System.out.println(cityPopList.get(j)+"    "   +ratio_duration+"    "+ratio_population);
				
			
			}
		}catch(Exception e){
			System.out.println(e);
		} 
		
		
		
		
	}  
}  

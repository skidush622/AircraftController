function done = NoCollision( my_LRF, in, opp_LRF, message)

			position_plane1= in;
			
            theta_plane1 = wrapTo360(my_LRF*90 + in.theta);
    
            if(in.x == in.xd && in.y == in.yd)
                position_plane1.x = in.x;
                position_plane1.y = in.y;
            elseif(theta_plane1 == 0 || theta_plane1 == 360)
                position_plane1.x = in.x + 1;
            elseif(theta_plane1 == 90)
                position_plane1.y = in.y + 1;
            elseif(theta_plane1 == 180)
                position_plane1.x = in.x - 1;
            elseif(theta_plane1 == 270)
                position_plane1.y = in.y - 1;
            end
            position_plane1.theta = theta_plane1;

			
			position_plane2 = message;
			theta_plane2 = wrapTo360(opp_LRF*90 + message.theta);
            
            if(message.x == message.xd && message.y == message.yd)
                position_plane2.x = message.x;
                position_plane2.y = message.y;
            elseif(theta_plane2 == 0 || theta_plane2 == 360)
                    position_plane2.x = position_plane2.x + 1;
                elseif(theta_plane2 == 90)
                    position_plane2.y = position_plane2.y + 1;
                elseif(theta_plane2 == 180)
                    position_plane2.x = position_plane2.x - 1;
                elseif(theta_plane2 == 270)
                    position_plane2.y = position_plane2.y - 1;
                end
                
                position_plane2.theta = theta_plane2;
            
                % (in.x == message.x) || (in.y == message.y)
			if((position_plane2.x== position_plane1.x) && (position_plane2.y== position_plane1.y))
				done = false;
            else
				done = true;
            end
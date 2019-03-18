function dir_value = getNextMove(in, message, aircraft_no)

    matrix1 = zeros(3,2);
    matrix2 = zeros(3,2);
    points = [in.xd,in.yd;in.x,in.y];
    distance = pdist(points,'euclidean');
    dir_value=0;
	
    % Calculates the next coordinates based on the theta and current coordinates
    if( ~(distance == 0))
        
        if( in.theta == 0 || in.theta == 360)
                   xF = in.x+1;
                   yF = in.y;
                   xR = in.x;
                   yR = in.y-1;
                   xL = in.x;
                   yL = in.y+1;
        elseif(in.theta == 90)
                   xF = in.x;
                   yF = in.y+1;
                   xR = in.x+1;
                   yR = in.y;
                   xL = in.x-1;
                   yL = in.y;
        elseif(in.theta == 180)
                   xF = in.x-1;
                   yF = in.y;
                   xR = in.x;
                   yR = in.y+1;
                   xL = in.x;
                   yL = in.y-1;
        elseif(in.theta == 270)
                   xF = in.x;
                   yF = in.y-1;
                   xR = in.x-1;
                   yR = in.y;
                   xL = in.x+1;
                   yL = in.y;
        end

        currentDistanceF = abs(in.xd-xF)+abs(in.yd-yF);
        currentDistanceR = abs(in.xd-xR)+abs(in.yd-yR);
        currentDistanceL = abs(in.xd-xL)+abs(in.yd-yL);

		    
		matrix1(1,1) = currentDistanceL;
		matrix1(2,1) = currentDistanceR;
		matrix1(3,1) = currentDistanceF;
        
		matrix1(1,2) = 1 ; 
		matrix1(2,2) = -1 ; 
		matrix1(3,2) = 0;
    
        
		%Sorting the distances to find the minimum possible distance and if step distances are equal then we check for euclidean distances
        
            for i=1:3
                for j=(i+1):3
                    if ( matrix1(i,1) >  matrix1(j,1))
                        temp=matrix1(i,1);
                        matrix1(i,1)=matrix1(j,1);
                        matrix1(j,1) = temp;
                    
                        temp=matrix1(i,2);
                        matrix1(i,2)=matrix1(j,2);
                        matrix1(j,2) = temp;
                    end
                end
            end
			dir_value = matrix1(1,2); 

            if( ~isempty(message) && mod(aircraft_no,2)==0)
                if( message.theta == 0 || message.theta == 360)
                         xF = message.x+1;
                         yF = message.y;
                         xR = message.x;
                         yR = message.y-1;
                         xL = message.x;
                         yL = message.y+1;
            elseif(message.theta == 90)
                         xF = message.x;
                         yF = message.y+1;
                         xR = message.x+1;
                         yR = message.y;
                         xL = message.x-1;
                         yL = message.y;
            elseif(message.theta == 180)
                         xF = message.x-1;
                         yF = message.y;
                         xR = message.x;
                         yR = message.y+1;
                         xL = message.x;
                         yL = message.y-1;
            elseif(message.theta == 270)
                         xF = message.x;
                         yF = message.y-1;
                         xR = message.x-1;
                         yR = message.y;
                         xL = message.x+1;
                         yL = message.y;
            end
        otherDistanceF = abs(message.xd - xF)+abs(message.yd - yF);
        otherDistanceR = abs(message.xd - xR)+abs(message.yd - yR);
        otherDistanceL = abs(message.xd - xL)+abs(message.yd - yL);
		
        matrix2(1,1) = otherDistanceL;
		matrix2(2,1) = otherDistanceR;
		matrix2(3,1) = otherDistanceF;
        
        
		matrix2(1,2) = 1 ; 
		matrix2(2,2) = -1 ; 
		matrix2(3,2) = 0; 

        
                for i=1:3
                    for j=(i+1):3
                        if ( matrix2(i,1) > matrix2(j,1))
                            temp=matrix2(i,1);
                            matrix2(i,1)=matrix2(j,1);
                            matrix2(j,1) = temp;
                    
                            temp=matrix2(i,2);
                            matrix2(i,2)=matrix2(j,2);
                            matrix2(j,2) = temp;
                        end
                    end
                end
            
                % calculate position of other plane
 
               for i=1:3
                   
                   	if(NoCollision(matrix1(i,2), in, matrix2(i,2), in.m))
						dir_value = matrix1(i,2);
                        break;
                    end
                   
               end
              
       end
end
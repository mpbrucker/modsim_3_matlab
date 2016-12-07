function play_movie()
    % prepares and opens videofile
    v = VideoWriter('pendulum.avi');
    open(v)
    
    % gets matrix of frames
    M = animate_data();
    % plays movie
    movie(M)
    
    % writes video file
    for i = 1:length(M)
        writeVideo(v, M(i)) % M(i) = frame
    end
    
    close(v)
end
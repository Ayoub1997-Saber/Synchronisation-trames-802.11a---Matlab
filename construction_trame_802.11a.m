function message = construction_message(u_n)

message = u_n / max(abs(u_n));

min_data = min (message);                                          
max_data = max (message);
mean_data = (max_data - min_data) / 3;

message(find(message < min_data + mean_data)) = -1;

message(find(message >= min_data + mean_data & message < min_data + 2 * mean_data)) = 0;

message(find(message >= min_data + 2 * mean_data)) = 1;

end
function d = pdist2(x,y)

lx = size(x,1);
ly = size(x,1);

d = zeros(lx,ly);

for ix=1:lx
    for iy=1:ly
        d(ix,iy) = sqrt(sum(x(ix,:) - y(iy,:)).^2);
    end
end
function H = histogram_binner(THETA, PHI, MAG)

h=zeros(3,3);
mini_PHI= -90;
maxi_PHI= -30;
mini_THETA= -90;
maxi_THETA= -30;
for i=1:3
    mini_PHI= -90;
    maxi_PHI= -30;
    for j=1:3
    LOG_MASK=  (PHI >= mini_PHI & PHI < maxi_PHI & THETA >= mini_THETA & THETA < maxi_THETA );
    h(i,j)=sum(MAG(LOG_MASK),'omitnan');
    mini_PHI=mini_PHI+60;
    maxi_PHI=maxi_PHI+60;
    end
    mini_THETA=mini_THETA+60;
    maxi_THETA=maxi_THETA+60;
end
H=[];
    for i=1:3
        H=[H,h(i,:)];
    end
  H=H/sum(H);
end

%manhattan plot for GWAS result by Meng Luo
% chr,position,P value
%ersmllm=1:1:1000;
%chr=chr(ersmllm);pos=pos(ersmllm);plm=plm(ersmllm);
mlssr=[chr pos plm];%
%mlssr=xlsread('fyx.xlsx');nchr=7;
[nsnp,phe]=size(mlssr);nchr=length(unique(chr));
%nasnp=label(lm);
%dims = size(nasnp);
k=1;
f(1,1)=mlssr(1,2)+2000000;
for i=2:1:nsnp
   if mlssr(i,1)~= mlssr(i-1,1)
    f(i,1)=f(i-1,1)+mlssr(i,2)+2000000;
    x(k)=f(i,1)-1000000;
    if k>1 
    xg(k)=(f(i-1,1)-x(k-1))/2+x(k-1);
    ch(k)=mlssr(i-1,1);
    else
    xg(k)=f(i-1,1)/2-mlssr(1,2)/2;
    end
    k=k+1;
   else
   f(i,1)=mlssr(i,2)-mlssr(i-1,2)+f(i-1,1); 
   ch(k)=mlssr(i-1,1);
    end 
end
xg(k)=(f(i,1)-x(k-1))/2+x(k-1);
ch(k)=mlssr(i,1);
for j=3:1:phe
for i=1:1:nsnp
    f(i,j-1)=-log10(mlssr(i,j));
end
i=1;
end
j=1;
for j=1:1:(phe-2)
    figure(j);
    cl=load('colorchrhg.txt');ncl=randperm(length(cl(:,1)));cl=cl(ncl,:);
    %cl=cl(1:nchr,:);% all kinds of color 
    scatter(f(:,1),f(:,j+1),10,cl(chr,:),'o','filled');%cl(mod(mlssr(:,1),nchr)+1,:)/1
    %display the gene name or not
    %text(f(lm,1),f(lm,j+1)+.15*4, nasnp(:,1:dims(2)),'FontSize', 10);
    chrs = unique(chr);
    chrs = chrs(:)';%p0=0;
  for c = chrs
      % Plot the SNPs on the chromosome.
      is = find(chr == c);
      maxpos = max(pos(is));
     % load cl.mat
      if ~isodd(c)
          %clr = unifrnd(0,1,1,3);
          clr=cl(c,:);
      else
          %clr = unifrnd(0,1,1,3);
          clr=cl(c,:);
      end
      % Add the chromosome number.
      %for il=1:nchr
      text(xg(c),-0.08* (max(-log10(plm)) - min(-log10(plm))),num2str(c),...
          'Color',cl(c,:),'FontSize',9,'HorizontalAlignment','center',...
          'VerticalAlignment','bottom','FontName','Times New Roman',...
          'FontWeight','bold','FontSize',14);
       %p0 = p0 + maxpos;
  end
  set(gca,'xlim',[f(1,1),f(nsnp,1)]);
  set(gca,'XTick', []);
  %set(gca,'XTickLabel',ch);
  set(gca,'TickDir','in');
  set(gca,'TickLength',[0.005,0.1]);
  set(gca,'FontName','Times New Roman', 'FontWeight','bold','FontSize',14);
  %xlabel('Chromosome');
  ylabel('-log_{10}(\itP)');
  xlh = xlabel('Chromosome');
  xlh.Position(2) = xlh.Position(2) - 1;
  hold on;
  %add the signifigant line
  ylm=-log10(0.05/nsnp);yl=[ylm,ylm];
  plot(get(gca,'xlim'),yl,'k:','LineWidth',1.5);
end

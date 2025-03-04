% GENOMEWIDEPLOT(CHR,POS,SCORE) shows the genome-wide scan the "Manhattan
% plot". Inputs CHR and POS specify the chromosome
% numbers and chromosomal positions of the markers. The SNPs are assumed to
% be ordered by chromosome number, then by position along the chromosome.
% SCORE is some measure of significance for all the markers, such as Bayes
% factor, posterior odds, or posterior inclusion probability.

function manhattanplot (chr, pos, p, snps,tickl,pvalue)

  % Alternating shades for chromosomes.
  %clr1 = rgb('midnightblue');
  %clr2 = rgb('cornflowerblue');
  %clr1=unifrnd(0,1,1,3);
  %clr2=unifrnd(0,1,1,3);
  % These are the SNPs to highlight in the Manhattan plot.
  if ~exist('snps')
    snps = [];
  end
  if ~exist('tickl')
    tickl = 0.06;
  end
   if ~exist('pvalue')
    pvalue = 0.05;
  end
  % Get the set of chromosomes represented by the SNPs.
  chrs = unique(chr);
  chrs = chrs(:)';
  
  % This is the current position in the plot.
  p0 = 0;
  p=-log10(p);
  % Repeat for each chromosome.
  hold on
  for c = chrs
    
    % Plot the SNPs on the chromosome.
    is = find(chr == c);
    maxpos = max(pos(is));
   % cl=unifrnd(0,1,22,3);
   % save cl.mat cl
    load cl.mat
    %cl=load('colorchrhg.txt');
   % cln=randperm(24);cl=cl(cln,:);
    if ~isodd(c)
      %clr = unifrnd(0,1,1,3);
      clr=cl(c,:);
    else
      %clr = unifrnd(0,1,1,3);
      clr=cl(c,:);
    end
    plot(p0 + pos(is),p(is),'o','MarkerFaceColor',clr,...
	 'MarkerEdgeColor',clr,'MarkerSize',5);
    %scatter(p0 + pos(is),p(is),clr,'o','filled');
    % Highlight these SNPs.
    is = find(chr(snps) == c);
    if isodd(c)
      clr = rgb('forestgreen');
    else
      clr = rgb('yellowgreen');
    end
    if ~isempty(is)
      plot(p0 + pos(snps(is)),p(snps(is)),'o','MarkerFaceColor',clr,...
	   'MarkerEdgeColor','none','MarkerSize',4);    
    end
    % Add the chromosome number.
    %for il=1:nchr
    text(p0 + maxpos/2,-tickl* (max(p) - min(p)),num2str(c),...
	 'Color',cl(c,:),'FontSize',9,'HorizontalAlignment','center',...
	 'VerticalAlignment','bottom','FontName','Times New Roman','FontWeight','bold','FontSize',12);
    %end

    % Move to the next chromosome.
    p0 = p0 + maxpos;
  end
  hold off
  set(gca,'XLim',[0 p0],'XTick',[],'YLim',[min(p) max(p)]);
  set(gca,'TickDir','in','TickLength',[0.000003 0.000003]);
  hold on;
  %add the signifigant line
  ylm=-log10(pvalue/length(p));yl=[ylm,ylm];
  plot(get(gca,'xlim'),yl,'k:','LineWidth',1.5);

  

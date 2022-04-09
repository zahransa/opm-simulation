figure
plot3(scalp.Vertices(:, 1), scalp.Vertices(:, 2), scalp.Vertices(:, 3), '.k');
grid on
axis equal
hold on
for ind = 1: 102
plot3(ChOPMn(ind).Loc(1, [1 2 4 3 1]), ChOPMn(ind).Loc(2, [1 2 4 3 1]), ChOPMn(ind).Loc(3, [1 2 4 3 1]), 'r-');
plot3(ChOPMt1(ind).Loc(1, [1 2 4 3 1]), ChOPMt1(ind).Loc(2, [1 2 4 3 1]), ChOPMt1(ind).Loc(3, [1 2 4 3 1]), 'g-');
plot3(ChOPMt2(ind).Loc(1, [1 2 4 3 1]), ChOPMt2(ind).Loc(2, [1 2 4 4 1]), ChOPMt2(ind).Loc(3, [1 2 4 3 1]), 'b-');
end 
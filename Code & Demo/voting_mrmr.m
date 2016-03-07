%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%File: voting_mrmr.m
%Author: Onur Ozuduru
%   e-mail: onur { dot } ozuduru { at } gmail { dot } com
%   github: github.com/onurozuduru
%
%License: The MIT License (MIT)
%
%   Copyright (c) 2015 Onur Ozuduru
%   Permission is hereby granted, free of charge, to any person obtaining a copy
%   of this software and associated documentation files (the "Software"), to deal
%   in the Software without restriction, including without limitation the rights
%   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%   copies of the Software, and to permit persons to whom the Software is
%   furnished to do so, subject to the following conditions:
%  
%   The above copyright notice and this permission notice shall be included in all
%   copies or substantial portions of the Software.
%  
%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%   SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = voting_mrmr(mrmrIt, mrmrK, samp, train, groupT, knnK, DIS)

[sampM, sampN] = size(samp);
unique_classes = unique(groupT);
voteChart = zeros(sampM, length(unique_classes));

for it = 1:mrmrIt
   [mrmrMat, mrmrClasses] = mrmr_sample_creator(horzcat(groupT, train));
   knn_voter(mrmr_mid_d(mrmrMat, mrmrClasses, mrmrK));
end

res = get_voting_results(voteChart);

    % Creates matrices that is size of [# data rows x # data columns] with replacement.
    % Returns mixed data sample and its classes vector.
    function [sampleMat, classVec] = mrmr_sample_creator(data)
        [datM, datN] = size(data);
        [sampleMat,] = datasample(data, datM, 'Replace', true);
        classVec = sampleMat(:, 1);
        sampleMat = sampleMat(:, 2:datN);
    end

    % Modifies voteChart according to results of mrmr.
    function knn_voter(mrmrRes)
        S = [];
        T = [];
        % Picks only choosen features by mrmr from sample and training.
        for j = 1:mrmrK
            S = horzcat(S, samp(:, mrmrRes(j)));
            T = horzcat(T, train(:, mrmrRes(j)));
        end
        knnRes = knnclassify(S, T, groupT, knnK, DIS);
        for j = 1:sampM
            indexVote = find(unique_classes == knnRes(j));
            voteChart(j, indexVote) = voteChart(j, indexVote) + 1;
        end
    end
    
    % Calculates the classes that takes most of the votes and
    %  returns a result vector which includes classes of samp.
    function andTheWinnersAre = get_voting_results(finalChart)
        andTheWinnersAre = zeros(sampM, 1);
        for i = 1:sampM
            [val, ind] = max(finalChart(i, :));
            andTheWinnersAre(i) = unique_classes(ind);
        end
    end
end

function [ residual ] = getresidual( truth , patch )
    residual = sum(sqrt(sum((truth - patch).^2,2)))
end


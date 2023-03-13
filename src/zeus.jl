"""
Transfer matrix for ZEUS experiment 
high-x data.

N = T K S
T = Transfer matrix (including data luminosity)
K - Radiative corrections
S = Born-level integrated sigma

Based on C++ code by R. Aggarwal.
"""

include("../data/zeus_transfer_matrix.jl")
include("../data/zeus_bin_edges.jl")

export get_pred_N
export get_data_events
export get_TM_elements
export get_K_elements
export get_L_data
export get_bin_info

export q2bins_M_begin
export q2bins_M_end
export xbins_M_begin
export xbins_M_end


function get_data_events(eMPp)
    if eMPp == 0
        return Data_Events_ePp
    else
        return Data_Events_eMp
    end
end


function get_K_elements(eMPp)
    if eMPp == 0
        return Kii_ePp
    else
        return Kii_eMp
    end
end


function get_L_data(eMPp)
    if eMPp == 0
        return Ld_ePp
    else
        return Ld_eMp
    end
end

function get_TM_elements(eMPp)
    
    lumi_data = get_L_data(eMPp)

    if eMPp == 1
        TM_elements = copy(TM_Elements_eMp)
    elseif eMPp == 0
        TM_elements = copy(TM_Elements_ePp)
    end
    
    for i in 1:429
        for j in 1:153
         TM_elements[i,j] = TM_elements[i,j] * lumi_data
        end
    end
    
    return TM_elements
end

function get_pred_N(Integ_xsec, eMPp)

    TM = get_TM_elements(eMPp);
    K = get_K_elements(eMPp)

    xsec_pred = zeros(153)
    for j in 1:153
        temp=0.
        for i in 1:429

        temp = temp +(TM[i,j]./K[i]) * Integ_xsec[i];
        end
        xsec_pred[j] = temp
    end

    return xsec_pred;

end

"""
    get_bin_info(n, quiet)

Get the bin egdes of the ZEUS 
detector space for a given 
bin number, `n`.
"""
function get_bin_info(n::Integer; quiet::Bool = false)

    if n < 1 || n > 153
        @error "Bin number n should be [1, 153]"
    end

    if !quiet

        @info "ZEUS detector bin" n BinQ2low[n] BinQ2high[n] Binxlow[n] Binxhigh[n]
        
    end

    return ([BinQ2low[n], BinQ2high[n]], [Binxlow[n], Binxhigh[n]])
end


const q2bins_M_begin = Float64.([400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 400, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 11000, 11000, 11000, 20000, 20000]);


const q2bins_M_end = Float64.([650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 650, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 800, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 950, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1100, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1300, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 1800, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2100, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2400, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 2800, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3200, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 3800, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 4500, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 6000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 8000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 11000, 20000, 20000, 20000, 30000, 30000]);


const xbins_M_begin = Float64.([0.0035, 0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.047, 0.05, 0.054, 0.059, 0.062, 0.065, 0.0675, 0.07, 0.073, 0.076, 0.079, 0.082, 0.085, 0.09, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.24, 0.26, 0.28, 0.3, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.7, 0.0035, 0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.054, 0.06, 0.07, 0.079, 0.088, 0.098, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.21, 0.23, 0.26, 0.28, 0.31, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.007, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.17, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.35, 0.4, 0.425, 0.45, 0.55, 0.007, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.044, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.205, 0.22, 0.24, 0.26, 0.28, 0.3, 0.34, 0.4, 0.5, 0.01, 0.015, 0.018, 0.021, 0.024, 0.029, 0.033, 0.038, 0.042, 0.048, 0.056, 0.063, 0.072, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.22, 0.24, 0.27, 0.3, 0.34, 0.4, 0.5, 0.01, 0.015, 0.017, 0.019, 0.022, 0.026, 0.03, 0.034, 0.038, 0.042, 0.048, 0.054, 0.062, 0.07, 0.078, 0.088, 0.1, 0.105, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.25, 0.3, 0.36, 0.5, 0.01, 0.018, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.05, 0.059, 0.066, 0.076, 0.086, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.34, 0.39, 0.45, 0.01, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.054, 0.06, 0.07, 0.078, 0.088, 0.11, 0.14, 0.17, 0.21, 0.26, 0.31, 0.43, 0.01, 0.025, 0.029, 0.033, 0.039, 0.048, 0.058, 0.063, 0.08, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.46, 0.025, 0.028, 0.032, 0.038, 0.044, 0.05, 0.058, 0.065, 0.076, 0.086, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.5, 0.025, 0.032, 0.038, 0.044, 0.05, 0.062, 0.072, 0.088, 0.11, 0.14, 0.17, 0.21, 0.25, 0.3, 0.36, 0.42, 0.54, 0.035, 0.042, 0.05, 0.06, 0.07, 0.085, 0.1, 0.115, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.4, 0.46, 0.58, 0.035, 0.05, 0.07, 0.096, 0.12, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.63, 0.035, 0.05, 0.07, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.44, 0.5, 0.56, 0.69, 0.065, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.35, 0.41, 0.47, 0.53, 0.59, 0.73, 0.105, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.57, 0.64, 0.78, 0.13, 0.256, 0.6, 0.25, 0.6]);


const xbins_M_end = Float64.([0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.047, 0.05, 0.054, 0.059, 0.062, 0.065, 0.0675, 0.07, 0.073, 0.076, 0.079, 0.082, 0.085, 0.09, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.24, 0.26, 0.28, 0.3, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.7, 0.999999, 0.007, 0.01, 0.012, 0.015, 0.017, 0.019, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.054, 0.06, 0.07, 0.079, 0.088, 0.098, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.21, 0.23, 0.26, 0.28, 0.31, 0.35, 0.4, 0.42, 0.435, 0.45, 0.5, 0.6, 0.999999, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.041, 0.044, 0.046, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.17, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.35, 0.4, 0.425, 0.45, 0.55, 0.99999, 0.01, 0.012, 0.015, 0.018, 0.022, 0.024, 0.026, 0.028, 0.03, 0.032, 0.034, 0.036, 0.038, 0.044, 0.05, 0.059, 0.067, 0.076, 0.085, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.205, 0.22, 0.24, 0.26, 0.28, 0.3, 0.34, 0.4, 0.5, 0.999999, 0.015, 0.018, 0.021, 0.024, 0.029, 0.033, 0.038, 0.042, 0.048, 0.056, 0.063, 0.072, 0.08, 0.09, 0.1, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.22, 0.24, 0.27, 0.3, 0.34, 0.4, 0.5, 0.999999, 0.015, 0.017, 0.019, 0.022, 0.026, 0.03, 0.034, 0.038, 0.042, 0.048, 0.054, 0.062, 0.07, 0.078, 0.088, 0.1, 0.105, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 0.22, 0.23, 0.25, 0.3, 0.36, 0.5, 0.999999, 0.018, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.05, 0.059, 0.066, 0.076, 0.086, 0.096, 0.11, 0.12, 0.13, 0.14, 0.15, 0.16, 0.17, 0.18, 0.19, 0.21, 0.23, 0.25, 0.28, 0.31, 0.34, 0.39, 0.45, 0.999999, 0.022, 0.025, 0.028, 0.032, 0.038, 0.044, 0.054, 0.06, 0.07, 0.078, 0.088, 0.11, 0.14, 0.17, 0.21, 0.26, 0.31, 0.43, 0.999999, 0.025, 0.029, 0.033, 0.039, 0.048, 0.058, 0.063, 0.08, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.46, 0.999999, 0.028, 0.032, 0.038, 0.044, 0.05, 0.058, 0.065, 0.076, 0.086, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.5, 0.999999, 0.032, 0.038, 0.044, 0.05, 0.062, 0.072, 0.088, 0.11, 0.14, 0.17, 0.21, 0.25, 0.3, 0.36, 0.42, 0.54, 0.999999, 0.042, 0.05, 0.06, 0.07, 0.085, 0.1, 0.115, 0.13, 0.16, 0.2, 0.24, 0.29, 0.34, 0.4, 0.46, 0.58, 0.999999, 0.05, 0.07, 0.096, 0.12, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.63, 0.999999, 0.05, 0.07, 0.096, 0.12, 0.15, 0.18, 0.22, 0.27, 0.32, 0.38, 0.44, 0.5, 0.56, 0.69, 0.99999, 0.1, 0.13, 0.16, 0.2, 0.24, 0.29, 0.35, 0.41, 0.47, 0.53, 0.59, 0.73, 1, 0.15, 0.19, 0.23, 0.28, 0.33, 0.39, 0.45, 0.51, 0.57, 0.64, 0.78, 0.99999, 0.256, 0.6, 0.99999, 0.6, 0.99999]);

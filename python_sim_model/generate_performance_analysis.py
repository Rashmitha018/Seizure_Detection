import matplotlib.pyplot as plt
import numpy as np
import os

# Set up the figure with 2x2 subplots
fig, axs = plt.subplots(2, 2, figsize=(14, 10))
fig.suptitle('FPGA Seizure Detection System: Performance & Resource Analysis', fontsize=18, fontweight='bold', color='#333333')

# --- 1. Processing Latency Comparison (Log Scale) ---
platforms = ['Standard CPU\n(Software)', 'GPU Edge\n(Nvidia Nano)', 'Proposed FPGA\n(Hardware)']
latencies = [15000, 5000, 10] # in nanoseconds (15us, 5us, 10ns)
bars1 = axs[0, 0].bar(platforms, latencies, color=['#ff9999', '#ffcc99', '#66b3ff'], edgecolor='black')
axs[0, 0].set_yscale('log')
axs[0, 0].set_ylabel('Processing Latency (ns) [Log Scale]', fontsize=12)
axs[0, 0].set_title('Latency Comparison: CPU vs GPU vs FPGA', fontsize=14)
axs[0, 0].grid(axis='y', linestyle='--', alpha=0.7)
for i, v in enumerate(latencies):
    axs[0, 0].text(i, v * 1.3, f"{v} ns", ha='center', fontweight='bold', fontsize=11)

# --- 2. Power Consumption Comparison ---
power_platforms = ['CPU/GPU\n(Average)', 'Proposed FPGA\n(Artix-7)']
power_watts = [15.0, 0.12] # 15 Watts vs 120 Milliwatts
bars2 = axs[0, 1].bar(power_platforms, power_watts, color=['#ff9999', '#99ff99'], edgecolor='black')
axs[0, 1].set_ylabel('Power Consumption (Watts)', fontsize=12)
axs[0, 1].set_title('Power Efficiency: Software vs Hardware Core', fontsize=14)
axs[0, 1].grid(axis='y', linestyle='--', alpha=0.7)
for i, v in enumerate(power_watts):
    axs[0, 1].text(i, v + 0.5, f"{v} W", ha='center', fontweight='bold', fontsize=11)

# --- 3. FPGA Resource Utilization (Artix-7 xc7a35t) ---
resources = ['Slice LUTs', 'Slice Registers', 'Block RAM']
used = [185, 112, 16.5]
available = [20800, 41600, 50]
utilization = [(u/a)*100 for u, a in zip(used, available)]

x = np.arange(len(resources))
width = 0.5
bars3 = axs[1, 0].bar(x, utilization, width, color=['#c2c2f0', '#c2c2f0', '#f0c2c2'], edgecolor='black')
axs[1, 0].set_ylabel('Utilization (%)', fontsize=12)
axs[1, 0].set_title('Post-Synthesis Resource Utilization', fontsize=14)
axs[1, 0].set_xticks(x)
axs[1, 0].set_xticklabels(resources, fontsize=11)
axs[1, 0].set_ylim(0, 40)
axs[1, 0].grid(axis='y', linestyle='--', alpha=0.7)
for bar in bars3:
    yval = bar.get_height()
    axs[1, 0].text(bar.get_x() + bar.get_width()/2, yval + 1, f"{yval:.2f}%", ha='center', va='bottom', fontweight='bold', fontsize=11)

# --- 4. Sliding Window Accuracy Trade-off ---
window_sizes = [128, 256, 512, 1024]
accuracies = [82.5, 94.0, 100.0, 96.5] 
axs[1, 1].plot(window_sizes, accuracies, marker='o', linestyle='-', color='#8c564b', linewidth=3, markersize=10)
axs[1, 1].set_xlabel('Sliding Window Size (Samples)', fontsize=12)
axs[1, 1].set_ylabel('Detection Accuracy (%)', fontsize=12)
axs[1, 1].set_title('Algorithm Tuning: Window Size vs Accuracy', fontsize=14)
axs[1, 1].grid(True, linestyle='--', alpha=0.7)
axs[1, 1].set_ylim(80, 105)
axs[1, 1].annotate('Optimal Hardware Config\n(W=512, 100%)', xy=(512, 100), xytext=(550, 88),
            arrowprops=dict(facecolor='black', shrink=0.05, width=2, headwidth=8),
            fontsize=12, fontweight='bold', bbox=dict(boxstyle="round,pad=0.3", fc="white", ec="black", lw=1))

# Final layout adjustments
plt.tight_layout(rect=[0, 0.03, 1, 0.95])

# Save the figure
output_path = os.path.join(os.path.dirname(__file__), 'system_performance_analysis.png')
plt.savefig(output_path, dpi=300, bbox_inches='tight')
print(f"Graph successfully generated and saved to: {output_path}")

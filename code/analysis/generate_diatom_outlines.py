"""
DIATOMIC - Parametric Diatom Outline Generator
Generate mathematical diatom outlines with Fourier descriptors
"""

import numpy as np
import matplotlib.pyplot as plt
from typing import Tuple, List

class DiatomOutline:
    """Base class for parametric diatom outlines"""
    
    def __init__(self, n_points: int = 200):
        self.n_points = n_points
        self.t = np.linspace(0, 2 * np.pi, n_points)
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        """Override in subclasses to return (x, y) coordinates"""
        raise NotImplementedError


class CentricDisc(DiatomOutline):
    """Circular centric diatom (Cyclotella-like)"""
    
    def __init__(self, radius: float = 1.0, wobble: float = 0.0, n_points: int = 200):
        super().__init__(n_points)
        self.radius = radius
        self.wobble = wobble
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        r = self.radius * (1 + self.wobble * np.sin(12 * self.t))
        x = r * np.cos(self.t)
        y = r * np.sin(self.t)
        return x, y


class CentricPolygon(DiatomOutline):
    """Polygonal centric diatom (Triceratium-like triangle)"""
    
    def __init__(self, n_sides: int = 3, radius: float = 1.0, 
                 corner_roundness: float = 0.2, n_points: int = 200):
        super().__init__(n_points)
        self.n_sides = n_sides
        self.radius = radius
        self.corner_roundness = corner_roundness
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        # Approximate polygon with rounded corners
        angle_step = 2 * np.pi / self.n_sides
        corners = np.array([
            [self.radius * np.cos(i * angle_step), 
             self.radius * np.sin(i * angle_step)]
            for i in range(self.n_sides)
        ])
        
        # Interpolate between corners with rounding
        x, y = [], []
        for i in range(self.n_sides):
            c1 = corners[i]
            c2 = corners[(i + 1) % self.n_sides]
            
            # Straight edge
            edge_t = np.linspace(self.corner_roundness, 1 - self.corner_roundness, 
                                 self.n_points // self.n_sides)
            edge_x = c1[0] + (c2[0] - c1[0]) * edge_t
            edge_y = c1[1] + (c2[1] - c1[1]) * edge_t
            
            x.extend(edge_x)
            y.extend(edge_y)
        
        return np.array(x), np.array(y)


class PennateNaviculoid(DiatomOutline):
    """Boat-shaped pennate diatom (Navicula-like)"""
    
    def __init__(self, length: float = 2.0, width: float = 0.6,
                 end_taper: float = 0.3, n_points: int = 200):
        super().__init__(n_points)
        self.length = length
        self.width = width
        self.end_taper = end_taper
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        # Ellipse with tapered ends
        t_half = self.t[self.t <= np.pi]
        t_half_norm = t_half / np.pi  # 0 to 1
        
        # Width varies along length (tapers at ends)
        width_profile = 1.0 - self.end_taper * (
            np.abs(t_half_norm - 0.5) * 2
        ) ** 2
        
        # Top half
        x_top = self.length * 0.5 * np.cos(t_half)
        y_top = self.width * 0.5 * np.sin(t_half) * width_profile
        
        # Bottom half (mirror)
        x_bottom = x_top[::-1]
        y_bottom = -y_top[::-1]
        
        x = np.concatenate([x_top, x_bottom])
        y = np.concatenate([y_top, y_bottom])
        
        return x, y


class PennateSigmoid(DiatomOutline):
    """S-curved pennate diatom"""
    
    def __init__(self, length: float = 2.0, width: float = 0.4,
                 curve_amplitude: float = 0.3, n_points: int = 200):
        super().__init__(n_points)
        self.length = length
        self.width = width
        self.curve_amplitude = curve_amplitude
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        # Create S-curve along the length
        y_center = np.linspace(-self.length/2, self.length/2, self.n_points//2)
        x_offset = self.curve_amplitude * np.sin(np.pi * y_center / self.length)
        
        # Width perpendicular to curve
        width_profile = self.width * (1 - (y_center / (self.length/2)) ** 2)
        
        # Top edge
        x_top = x_offset + width_profile / 2
        y_top = y_center
        
        # Bottom edge (reversed)
        x_bottom = x_offset[::-1] - width_profile[::-1] / 2
        y_bottom = y_center[::-1]
        
        x = np.concatenate([x_top, x_bottom])
        y = np.concatenate([y_top, y_bottom])
        
        return x, y


class PennateCymbelloid(DiatomOutline):
    """Banana/crescent shaped pennate (dorsiventral)"""
    
    def __init__(self, length: float = 2.0, width: float = 0.5,
                 dorsal_curve: float = 0.4, n_points: int = 200):
        super().__init__(n_points)
        self.length = length
        self.width = width
        self.dorsal_curve = dorsal_curve
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        y_center = np.linspace(-self.length/2, self.length/2, self.n_points//2)
        
        # Asymmetric curve (dorsal side more curved)
        curve = self.dorsal_curve * (y_center / (self.length/2)) ** 2
        
        # Width varies
        width_profile = self.width * (1 - 0.5 * (y_center / (self.length/2)) ** 2)
        
        # Dorsal (upper) edge - more curved
        x_dorsal = curve + width_profile / 2
        y_dorsal = y_center
        
        # Ventral (lower) edge - flatter
        x_ventral = curve[::-1] * 0.3 - width_profile[::-1] / 2
        y_ventral = y_center[::-1]
        
        x = np.concatenate([x_dorsal, x_ventral])
        y = np.concatenate([y_dorsal, y_ventral])
        
        return x, y


class CentricStellate(DiatomOutline):
    """Star-shaped centric with radiating processes"""
    
    def __init__(self, disc_radius: float = 0.5, process_length: float = 1.0,
                 n_arms: int = 8, n_points: int = 200):
        super().__init__(n_points)
        self.disc_radius = disc_radius
        self.process_length = process_length
        self.n_arms = n_arms
    
    def get_outline(self) -> Tuple[np.ndarray, np.ndarray]:
        x, y = [], []
        points_per_arm = self.n_points // self.n_arms
        
        for i in range(self.n_arms):
            angle = 2 * np.pi * i / self.n_arms
            angle_next = 2 * np.pi * (i + 1) / self.n_arms
            
            # Process extends from disc
            t_arm = np.linspace(0, 1, points_per_arm // 2)
            r_arm = self.disc_radius + self.process_length * t_arm
            
            # Arm outline
            for r, t in zip(r_arm, t_arm):
                # Taper the arm
                width = 0.15 * (1 - t)
                a1 = angle + width * (1 - t)
                a2 = angle - width * (1 - t)
                
                x.append(r * np.cos(a1))
                y.append(r * np.sin(a1))
            
            # Return along other side of arm
            for r, t in zip(r_arm[::-1], t_arm[::-1]):
                width = 0.15 * (1 - t)
                a = angle - width * (1 - t)
                x.append(r * np.cos(a))
                y.append(r * np.sin(a))
        
        return np.array(x), np.array(y)


def generate_gallery():
    """Generate a gallery of all diatom types"""
    fig, axes = plt.subplots(3, 3, figsize=(15, 15))
    fig.suptitle('Diatomic Outline Gallery', fontsize=16, fontweight='bold')
    
    diatoms = [
        (CentricDisc(radius=1.0, wobble=0.05), "Centric Disc\n(Cyclotella)"),
        (CentricPolygon(n_sides=3, corner_roundness=0.3), "Triangular\n(Triceratium)"),
        (CentricPolygon(n_sides=6, corner_roundness=0.2), "Hexagonal\n(Coscinodiscus)"),
        (CentricStellate(n_arms=8, process_length=0.8), "Stellate\n(Chaetoceros)"),
        (PennateNaviculoid(length=2.5, width=0.7), "Naviculoid\n(Navicula)"),
        (PennateSigmoid(length=2.5, curve_amplitude=0.4), "Sigmoid\n(Gyrosigma)"),
        (PennateCymbelloid(length=2.5, dorsal_curve=0.5), "Cymbelloid\n(Cymbella)"),
        (PennateNaviculoid(length=1.5, width=0.3, end_taper=0.8), "Lanceolate\n(Pinnularia)"),
        (CentricPolygon(n_sides=5, corner_roundness=0.25), "Pentagonal\n(Multi-sided)")
    ]
    
    for ax, (diatom, title) in zip(axes.flat, diatoms):
        x, y = diatom.get_outline()
        
        ax.plot(x, y, 'b-', linewidth=2)
        ax.fill(x, y, alpha=0.2, color='lightblue')
        ax.set_aspect('equal')
        ax.grid(True, alpha=0.3)
        ax.set_title(title, fontweight='bold')
        ax.set_xlabel('μm')
        ax.set_ylabel('μm')
    
    plt.tight_layout()
    plt.savefig('diatom_outlines_gallery.png', dpi=150, bbox_inches='tight')
    print("Gallery saved as 'diatom_outlines_gallery.png'")


def export_outline_to_json(diatom: DiatomOutline, filename: str):
    """Export outline to JSON for use in web viewer"""
    import json
    
    x, y = diatom.get_outline()
    
    data = {
        "type": diatom.__class__.__name__,
        "n_points": len(x),
        "outline": {
            "x": x.tolist(),
            "y": y.tolist()
        }
    }
    
    with open(filename, 'w') as f:
        json.dump(data, f, indent=2)
    
    print(f"Outline exported to {filename}")


def example_usage():
    """Example usage of the outline generators"""
    
    # Generate individual diatom
    diatom = PennateNaviculoid(length=2.5, width=0.8, end_taper=0.4)
    x, y = diatom.get_outline()
    
    plt.figure(figsize=(10, 5))
    plt.plot(x, y, 'b-', linewidth=2)
    plt.fill(x, y, alpha=0.2, color='lightblue')
    plt.axis('equal')
    plt.grid(True, alpha=0.3)
    plt.title('Naviculoid Pennate Diatom', fontsize=14, fontweight='bold')
    plt.xlabel('μm')
    plt.ylabel('μm')
    plt.savefig('example_naviculoid.png', dpi=150, bbox_inches='tight')
    print("Example saved as 'example_naviculoid.png'")
    
    # Export to JSON
    export_outline_to_json(diatom, 'naviculoid_outline.json')


if __name__ == "__main__":
    # Generate full gallery
    generate_gallery()
    
    # Generate example
    example_usage()

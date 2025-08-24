import React, { useState } from "react";
import * as XLSX from "xlsx";

const DataReport = () => {
    const [data, setData] = useState<any[]>([]);
    const [starttime, setStartTime] = useState<string | null>(null);
    const [endtime, setEndTime] = useState<string | null>(null);
    const [total, setTotal] = useState<number | null>(null);

    const handleFileUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
        const uploadedFile = e.target?.files;
        if (!uploadedFile || uploadedFile.length === 0) return;

        const reader = new FileReader();
        reader.onload = (event: ProgressEvent<FileReader>) => {
            const bdata = event.target?.result;
            if (!bdata) return;
            const workbook = XLSX.read(bdata, { type: "array" });
            const sheet = workbook.Sheets[workbook.SheetNames[0]];

            const jsonData = XLSX.utils.sheet_to_json(sheet, {
                raw: true,
                defval: "",
                range: 7
            });

            console.info("Loaded rows (first 5):", jsonData.slice(0, 5));
            if (Array.isArray(jsonData) && jsonData.length > 0 && typeof jsonData[0] === "object" && jsonData[0] !== null) {
                console.info("Keys (columns):", Object.keys(jsonData[0] as Record<string, any>));
            } else {
                console.info("No rows or unexpected format for jsonData[0]:", jsonData[0]);
            }
            setData(jsonData as any[]);
        };
        reader.readAsArrayBuffer(uploadedFile[0]);
    };

    const extractTime = (value: any) => {
        if (value instanceof Date) {
            const h = String(value.getHours()).padStart(2, "0");
            const m = String(value.getMinutes()).padStart(2, "0");
            const s = String(value.getSeconds()).padStart(2, "0");
            return `${h}:${m}:${s}`;
        }
        if (typeof value === "number") {
            const frac = value % 1;
            const totalSeconds = Math.round(frac * 24 * 3600);
            const h = String(Math.floor(totalSeconds / 3600)).padStart(2, "0");
            const m = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, "0");
            const s = String(totalSeconds % 60).padStart(2, "0");
            return `${h}:${m}:${s}`;
        }
        if (typeof value === "string" && value.trim() !== "") {
            const parts = value.trim().split(":");
            const h = String(parts[0] || "00").padStart(2, "0");
            const m = String(parts[1] || "00").padStart(2, "0");
            const s = String(parts[2] || "00").padStart(2, "0");
            return `${h}:${m}:${s}`;
        }
        return "00:00:00";
    };

    const toSeconds = (time: string) => {
        const [h = "0", m = "0", s = "0"] = time.split(":");
        return Number(h) * 3600 + Number(m) * 60 + Number(s);
    };

    const parseAmount = (val: any) => {
        if (typeof val === "number") return val;
        if (typeof val === "string") {
            const cleaned = val.replace(/\./g, "").replace(/,/g, "").trim();
            return Number(cleaned) || 0;
        }
        return 0;
    };

    const calculateTotal = () => {
        if (!starttime || !endtime) {
            console.warn("Vui lòng chọn start và end time");
            return;
        }

        console.info(`Calculating total from ${starttime} to ${endtime}`);
        const startSec = toSeconds(starttime);
        const endSec = toSeconds(endtime);

        const filteredData = data.filter((item) => {
            const rawTime = item["Giờ"] ?? item["Giờ"] ?? item["Gio"] ?? item["Time"] ?? item["Hour"];
            if (rawTime === undefined) {
                console.info("Sample item keys:", Object.keys(item));
            }
            const itemTime = extractTime(rawTime);
            const itemSec = toSeconds(itemTime);
            return itemSec >= startSec && itemSec <= endSec;
        });

        const totalAmount = filteredData.reduce((sum, item) => sum + parseAmount(item["Thành tiền (VNĐ)"]), 0);
        setTotal(totalAmount);
        console.info("Filtered rows count:", filteredData.length);
        console.info("Filtered Data sample:", filteredData.slice(0, 5));
        console.info("Total Amount:", totalAmount);
    };

    return (
        <div className="datareport-container">
            <h2 className="datareport-title">Data Report</h2>
            <div className="datareport-section">
                <label htmlFor="file-upload" className="datareport-label">Upload .xlsx/.xls File</label>
                <input type="file" id="file-upload" onChange={handleFileUpload} className="datareport-input" />
            </div>
            <div className="datareport-row">
                <div className="datareport-col">
                    <label htmlFor="start-time" className="datareport-label">Start Time</label>
                    <input type="time" id="start-time" step={1} onChange={(e) => setStartTime(e.target.value)} className="datareport-input" />
                </div>
                <div className="datareport-col">
                    <label htmlFor="end-time" className="datareport-label">End Time</label>
                    <input type="time" id="end-time" step={1} onChange={(e) => setEndTime(e.target.value)} className="datareport-input" />
                </div>
            </div>
            <button onClick={calculateTotal} className="datareport-btn">
                Calculate Total
            </button>
            {total !== null && (
                <div className="datareport-result">
                    <span className="datareport-result-label">Total Amount:</span>
                    <div className="datareport-result-value">{total.toLocaleString("vi-VN", { style: "currency", currency: "VND" })}</div>
                </div>
            )}
        </div>
    );
};

export default DataReport;
